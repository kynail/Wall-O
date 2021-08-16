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

# TCP SERVER

import socket
import base64
import re
import threading
from PIL import Image
from io import BytesIO

HOST = '127.0.0.1'
PORT = 8083

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


# SETUP TCP Server
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)

# Analyse l'image qui a été reçu par le serveur
def base64Image(data, socket):
    print("get Base 64 image")

    # A faire : verifier le bon format de l'image en base 64 sinon crash
    decoded_data = base64.b64decode(data)
    np_data = np.fromstring(decoded_data,np.uint8)
    original_image = cv2.imdecode(np_data,cv2.IMREAD_UNCHANGED)

    original_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2RGB)

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
    print("FINAL NAMES ", names)

    #image.show()
    image = cv2.cvtColor(np.array(image), cv2.COLOR_BGR2RGB)

    _, img_encoded = cv2.imencode('.jpg', image)
    final_image = (base64.b64encode(img_encoded)).decode()
    socket.send(('fish ' + names + " " + final_image + "\r\n").encode())


# Boucle du serveur en attente d'images
while True:
    dataArray = []
    print('En attente de connexion')
    conn, addr = s.accept()

    try:
        print('adresse API', addr)
        while True:
            data = conn.recv(16)
            if data:
                res = data.decode('utf-8')

                stock = res.replace("\r\n", "")
                dataArray.append(stock)

                if res.find("\r\n") != -1:
                    separator = ""
                    finalresult = separator.join(dataArray)
                    print("final res =", finalresult[0:11])
                    finalresult = finalresult.encode('utf-8')
                    print("data =", finalresult[0:20])

                    # if finalresult[0:11] == "data:image/":
                    base64Image(finalresult, conn)
                    # else:
                    #   conn.send(('recu :' + finalresult).encode())
                    dataArray.clear()
            else:
                break
    except socket.error:
        print('socket error')
    finally:
        conn.close()






# read image
# original_image = cv2.imread(images)
# original_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2RGB)

# image_data = cv2.resize(original_image, (input_size, input_size))
# image_data = image_data / 255.

# images_data = []
# for i in range(1):
#     images_data.append(image_data)
# images_data = np.asarray(images_data).astype(np.float32)

# infer = saved_model_loaded.signatures['serving_default']
# batch_data = tf.constant(images_data)
# pred_bbox = infer(batch_data)
# for key, value in pred_bbox.items():
#     boxes = value[:, :, 0:4]
#     pred_conf = value[:, :, 4:]

# boxes, scores, classes, valid_detections = tf.image.combined_non_max_suppression(
#     boxes=tf.reshape(boxes, (tf.shape(boxes)[0], -1, 1, 4)),
#     scores=tf.reshape(
#         pred_conf, (tf.shape(pred_conf)[0], -1, tf.shape(pred_conf)[-1])),
#     max_output_size_per_class=50,
#     max_total_size=50,
#     iou_threshold=0.45,
#     score_threshold=0.25
# )
# pred_bbox = [boxes.numpy(), scores.numpy(), classes.numpy(),
#              valid_detections.numpy()]
# image = utils.draw_bbox(original_image, pred_bbox)
# image = Image.fromarray(image.astype(np.uint8))

# image.show()
# image = cv2.cvtColor(np.array(image), cv2.COLOR_BGR2RGB)
