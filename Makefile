.PHONY: all

all: klipper moonraker fluidd mjpg-streamer mainsail

klipper: .build/klipper-dep

moonraker: .build/moonraker-dep

fluidd: .build/fluidd-dep

mainsail: .build/mainsail-dep

mjpg-streamer: .build/mjpg-streamer-dep

.build:
	mkdir -p .build

.build/klipper-dep: .build
	docker build -t klipper "https://github.com/Klipper3d/klipper.git#master" -f scripts/Dockerfile
	touch $@

.build/moonraker-dep: .build
	docker build src/moonraker -t moonraker
	touch $@

.build/fluidd-dep: .build
	docker build . -t moonraker -f src/fluidd/Dockerfile
	touch $@

.build/mjpg-streamer-dep: .build
	#docker build -t mjpg-streamer "https://github.com/jacksonliam/mjpg-streamer.git" -f mjpg-streamer-experimental/Dockerfile
	docker build -t mjpg-streamer src/mjpg-streamer
	touch $@

.build/mainsail-dep: .build
	docker build . -t mainsail -f src/mainsail/Dockerfile
	touch $@
