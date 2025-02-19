BOARD=BigTreeTech\ SKR\ Mini\ E3\ v3
UI=MarlinUI
CE=podman
CONTAINER_IMAGE := local/marlin-dev

build: config-custom
	@if ! ${CE} images -q ${CONTAINER_IMAGE} > /dev/null ; then ${MAKE} container-build ; fi
	${CE} run --rm -it \
		-v ./Marlin:/code:z \
		-v platformio-cache:/root/.platformio \
		${CONTAINER_IMAGE} \
		platformio run --silent -e STM32G0B1RE_btt
	mkdir -p ./build
	cp ./Marlin/.pio/build/STM32G0B1RE_btt/firmware.bin ./build
	cp -r ./Configurations/config/examples/Creality/Ender-3\ V2/LCD\ Files/DWIN_SET ./build

clean:
	rm -rf ./build/*
	git submodule deinit -f .
	git submodule update --init

config-default:
	rm -rf ./Marlin/Marlin/Configuration*
	cp -rf ./Configurations/config/examples/Creality/Ender-3\ V2/${BOARD}/${UI}/* ./Marlin/Marlin

config-custom:
	rm -rf ./Marlin/Marlin/Configuration*
	cp -rf ./Custom/* ./Marlin/Marlin

container-build:
	${CE} build -t ${CONTAINER_IMAGE} -f ./Marlin/docker/Dockerfile .

init:
	git submodule update --init