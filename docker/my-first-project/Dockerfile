FROM ubuntu:latest

WORKDIR /app

COPY hello-world.py /app
RUN apt update -y

RUN apt install python3
RUN apt install python3-pip

CMD ["python3", "hello-world.py"]

