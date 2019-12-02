# Partially taken from https://github.com/allenai/allennlp/blob/master/Dockerfile.pip
FROM python:3.6.8-stretch

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

ENV PATH /usr/local/nvidia/bin/:$PATH
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# Tell nvidia-docker the driver spec that we need as well as to
# use all available devices, which are mounted at /usr/local/nvidia.
# The LABEL supports an older version of nvidia-docker, the env
# variables a newer one.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
LABEL com.nvidia.volumes.needed="nvidia_driver"

# ARG does not work in old docker versions :(, use harcoded allennlp version
# in requirements.txt
WORKDIR /usr/app/
COPY /src /usr/app/

ENV ALLENNLP_VERSION=v0.9.0
RUN pip install -r requirements.txt

EXPOSE 8000
ENTRYPOINT ["python", "app.py"]

