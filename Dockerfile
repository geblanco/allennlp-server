# Partially taken from https://github.com/allenai/allennlp/blob/master/Dockerfile.pip
FROM python:3.7

WORKDIR /usr/app/
COPY /src /usr/app/

RUN pip install -r requirements.txt

# install nodejs and forever command
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt install -y nodejs && \
  npm install -g forever

EXPOSE 8000

# long-running process
ENTRYPOINT ["forever", "-c", "python", "app.py", "--model", "/data/fine-grained-ner-model-elmo-2018.12.21.tar.gz", "--port", "8000", "--routes", "ner"]