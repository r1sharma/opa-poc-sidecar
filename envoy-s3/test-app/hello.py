# hello.py
import boto3
import logging
logging.basicConfig(level=logging.DEBUG)

from flask import Flask
import os


s3_client = boto3.client('s3', 
                      aws_access_key_id=os.getenv("AWS_ACCESS_KEY_ID"),
                      aws_secret_access_key=os.getenv("AWS_SECRET_ACCESS_KEY"),
                      aws_session_token=os.getenv("AWS_SESSION_TOKEN")
                      )
objects = s3_client.list_objects_v2(Bucket='opa-bundle-rest')


for obj in objects['Contents']:
    print(obj['Key'])

app = Flask(__name__)

@app.route("/")
def hello_world():
    return obj['Key']
