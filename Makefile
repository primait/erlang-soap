APP := bet365-soap

.PHONY: all compile ct clean docker-build docker

all: compile

compile:
	rebar3 get-deps
	rebar3 compile

ct:
	rebar3 ct

clean:
	rebar3 clean
	rm -rf _build

docker-build:
	docker build \
		--tag $(APP) \
		--build-arg UID=$(shell id -u) \
		--build-arg GID=$(shell id -g) \
		$(PWD)

docker: docker-build
	docker run \
		--rm \
		--tty=true \
		--interactive=true \
		--name $(APP) \
		--volume "$(PWD):/home/app/src" \
		--workdir=/home/app/src \
		$(APP) sh
