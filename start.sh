#!/bin/bash

container_name='allennlp-server'
docker rm $container_name
docker run -d -p 8000:8000 --name $container_name $container_name:latest