FROM golang:latest 
RUN mkdir /app 

ARG redis_host=127.0.0.1
ARG redis_port=6378
ARG mqtt_port=1883


ENV REDIS_HOST $redis_host
ENV REDIS_PORT $redis_port
ENV MQTT_PORT $mqtt_port


ADD . $GOPATH/src/gossipd
WORKDIR $GOPATH/src/gossipd 


RUN go-wrapper download
RUN go-wrapper install
RUN go build -o main . 

RUN ["go", "test", "-v"]


CMD ["gossipd"]