.PHONY: all push

all: klipper fluidd mjpg-streamer mainsail

klipper: .build/klipper-dep

fluidd: .build/fluidd-dep

mainsail: .build/mainsail-dep

mjpg-streamer: .build/mjpg-streamer-dep

.build:
	mkdir -p .build

.build/klipper-dep: .build
	docker buildx build --platform linux/arm64 -t dawei06/klipper src/klipper -o type=docker
	touch $@

.build/fluidd-dep: .build
	docker buildx build --platform linux/arm64 -t dawei06/fluidd src/fluidd -o type=docker
	touch $@

.build/mjpg-streamer-dep: .build
	docker buildx build --platform linux/arm64 -t dawei06/mjpg-streamer src/mjpg-streamer -o type=docker
	touch $@

.build/mainsail-dep: .build
	docker buildx build --platform linux/arm64 -t dawei06/mainsail src/mainsail -o type=docker
	touch $@

push:
	docker push dawei06/klipper
	docker push dawei06/mainsail
	docker push dawei06/mjpg-streamer
	docker push dawei06/fluidd
