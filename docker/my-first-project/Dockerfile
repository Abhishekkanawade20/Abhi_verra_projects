FROM ubuntu:latest

WORKDIR /app

COPY hello-world.py /app
RUN sudo apt update -y

RUN sudo apt install python3
RUN sudo apt install python3-pip

CMD ["python3", "hello-world.py"]

