# syntax=docker/dockerfile:1

FROM --platform=linux/amd64 python:3.8-slim-buster as build

WORKDIR /python-docker
COPY . .
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
ENV FLASK_APP=hello.py
CMD ["flask", "run", "--host", "0.0.0.0"]