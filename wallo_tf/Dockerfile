FROM tensorflow/tensorflow:2.3.0rc0

# Create app directory
WORKDIR /usr/src/app

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends python3.6 python3-pip \
  && apt-get clean

COPY . .

RUN pip install -r requirements.txt

CMD ["python","./app.py"]