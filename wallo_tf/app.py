from flask import Flask, request, Response, jsonify
from tensorflow.compat.v1 import InteractiveSession
from tensorflow.compat.v1 import ConfigProto
import numpy as np
import cv2
from PIL import Image
from tensorflow.python.saved_model import tag_constants
from core.yolov4 import filter_boxes
import core.utils as utils
from absl.flags import FLAGS
from absl import app, flags, logging
import tensorflow as tf
import os
import base64
from PIL import Image
from io import BytesIO

app = Flask(__name__)

weights_path = "./checkpoints/custom-416"
classes_path = "./data/classes/custom.names"
input_size = 416
# images = "./data/images/clown.jpg"


# SETUP YOLO
physical_devices = tf.config.experimental.list_physical_devices('GPU')
if len(physical_devices) > 0:
    tf.config.experimental.set_memory_growth(physical_devices[0], True)

config = ConfigProto()
config.gpu_options.allow_growth = True
session = InteractiveSession(config=config)

# Load model
saved_model_loaded = tf.saved_model.load(
    weights_path, tags=[tag_constants.SERVING])
print("model load")


@app.route("/")
def home():
    return "Hello World from python server"

@app.route("/analyse", methods=['POST'])
def base64Image():
    # A faire : verifier le bon format de l'image en base 64 sinon crash
    image = request.files["images"]
    image_name = "fish.png"
    image.save(os.path.join(os.getcwd(), image_name))
    img_raw = tf.image.decode_image(open(image_name, 'rb').read(), channels=3)
    original_image = tf.expand_dims(img_raw, 0)

    original_image = cv2.cvtColor(img_raw.numpy(), cv2.COLOR_BGR2RGB)
    image_data = cv2.resize(original_image, (input_size, input_size))
    image_data = image_data / 255.

    images_data = []
    for i in range(1):
        images_data.append(image_data)
    images_data = np.asarray(images_data).astype(np.float32)

    infer = saved_model_loaded.signatures['serving_default']
    batch_data = tf.constant(images_data)

    pred_bbox = infer(batch_data)
    for key, value in pred_bbox.items():
        boxes = value[:, :, 0:4]
        pred_conf = value[:, :, 4:]

    boxes, scores, classes, valid_detections = tf.image.combined_non_max_suppression(
        boxes=tf.reshape(boxes, (tf.shape(boxes)[0], -1, 1, 4)),
        scores=tf.reshape(
            pred_conf, (tf.shape(pred_conf)[0], -1, tf.shape(pred_conf)[-1])),
        max_output_size_per_class=50,
        max_total_size=50,
        iou_threshold=0.45,
        score_threshold=0.25
    )
    pred_bbox = [boxes.numpy(), scores.numpy(), classes.numpy(),
                 valid_detections.numpy()]
    image = utils.draw_bbox(original_image, pred_bbox)
    image = Image.fromarray(image.astype(np.uint8))

    # Récupération des infos
    num_objects = valid_detections.numpy()[0]
    classes = classes.numpy()[0]
    classes = classes[0:int(num_objects)]
    precision = scores.numpy()[0]
    precision = precision[0:int(num_objects)]
    class_names = utils.read_class_names(classes_path)

    names = []
    for i in range(num_objects):
        class_indx = int(classes[i])
        class_name = class_names[class_indx]
        current_precision = str(round(precision[i], 2))
        names.append(class_name + ":" + current_precision)

    names = ','.join(names)

    image = cv2.cvtColor(np.array(image), cv2.COLOR_BGR2RGB)

    _, img_encoded = cv2.imencode('.png', image)
    final_image = (base64.b64encode(img_encoded)).decode()

    # remove temporary image
    os.remove(image_name)

    return {"fishes": names, "image": final_image}

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8000)
