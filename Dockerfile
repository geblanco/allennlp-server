# Partially taken from https://github.com/allenai/allennlp/blob/master/Dockerfile.pip
FROM python:3.7

WORKDIR /usr/app/
COPY /src /usr/app/

RUN pip install -r requirements.txt

EXPOSE 8000
ENTRYPOINT ["python", "app.py"]

