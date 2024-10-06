FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.6 python3.6-dev python3-pip python3.6-distutils

    

WORKDIR /app
COPY requirements.txt .

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1

# Upgrade pip and setuptools
RUN python3.6 -m pip install --upgrade pip setuptools

RUN pip3 install -r requirements.txt
RUN pip3 install gunicorn==19.9.0

ADD ./backend /app/backend
ADD ./docker /app/docker
ADD ./notebooks /app/notebooks
ADD ./research /app/research

RUN chmod +x /app/docker/backend/wsgi-entrypoint.sh
RUN chmod +x /app/backend/server/manage.py

RUN mkdir -p /app/backend/server/static