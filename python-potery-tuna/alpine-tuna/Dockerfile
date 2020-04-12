FROM alpine:latest 

RUN echo https://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing/ >> /etc/apk/repositories 
RUN echo https://mirrors.tuna.tsinghua.edu.cn/alpine/edge/community/ >> /etc/apk/repositories 
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories 
RUN apk update 
RUN apk add poetry 

COPY qbot /qbot 
WORKDIR /qbot 
RUN poetry install 
