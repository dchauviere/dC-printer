FROM alpine

RUN apk --no-cache --update add \
      git \
      build-base \
      make \
      cmake \
      jpeg-dev \
      linux-headers

RUN git clone https://github.com/jacksonliam/mjpg-streamer.git 

WORKDIR /mjpg-streamer/mjpg-streamer-experimental

RUN mkdir _build \
  && cd _build \
  # && cmake -DENABLE_HTTP_MANAGEMENT=ON .. \
  && cmake .. \
  && make \
  && make install

EXPOSE 8080/TCP

ENTRYPOINT ["/mjpg-streamer/mjpg-streamer-experimental/docker-start.sh", "output_http.so -w ./www"]

CMD ["input_uvc.so"]
