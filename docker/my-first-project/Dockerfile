FROM ubuntu:latest

WORKDIR /app

COPY . /app
RUN apt-get update -y

RUN apt-get install python3 -y
RUN apt-get install python3-pip -y

CMD ["python3", "hello-world.py"]




