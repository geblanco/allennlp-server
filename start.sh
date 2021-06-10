#!/bin/bash

if [[ ! -d "models" ]]; then
  mkdir models
fi

model_url="https://storage.googleapis.com/allennlp-public-models"
model_name="fine-grained-ner.2021-02-11.tar.gz"

[[ ! -f "models/${model_name}" ]] && wget "${model_url}/${model_name}" -O "models/${model_name}"

./stop.sh

docker rm allennlp_server_1
docker run -d -v `pwd`/models:/usr/app/models -p 9012:8000 --name allennlp_server_1 allennlp_server:latest --models models/$model_name --routes ner

