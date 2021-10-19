IMAGE_NAME := shusky/finbert:0.1.0
CONTAINER_NAME := finbert.sakagawa

.PHONY: build
build:
	@docker build . -t $(IMAGE_NAME)

.PHONY: run
run:
	@docker run --rm -it \
		-u root \
		--name $(CONTAINER_NAME) \
		-v $(shell pwd):/var/www \
		$(IMAGE_NAME) \
		bash

.PHONY: run/gpu
run/gpu:
	@docker run --rm -it \
		--gpus all \
		-u root \
		--name $(CONTAINER_NAME) \
		-v $(shell pwd):/var/www \
		$(IMAGE_NAME) \
		bash
