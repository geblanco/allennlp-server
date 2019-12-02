#!/bin/bash

if [[ ! -d "models" ]]; then
  mkdir models
fi

if [[ "$(ls models | wc -l)" -eq 0 ]]; then
  echo "Empty models dir!"
fi

container_name='allennlp-server'
docker rm $container_name
echo "Run:"
echo "docker run -d -p 8000:8000 -v `pwd`/models:/usr/app/models --name $container_name $container_name:latest --models <model_1> [, <model_2>] --routes <route_model_1> [, <route_model_2>]"
