IMAGE_NAME ?= "unircalculator"
CONTAINER_NAME ?= "services_calculator"
IMAGE_TAG ?= "latest"	
PORT_FLASK = 5000
PORT_WIREMOCK = 9090

FULL_IMAGE_NAME := $(IMAGE_NAME):$(IMAGE_TAG)
.PHONY: build
# 1. buil the Docker image
build:
	@echo "Building Docker image: $(FULL_IMAGE_NAME)"
	docker build -t $(FULL_IMAGE_NAME) .


#2: runt the Docker container
run: stop
	@echo "Running Docker container from image: $(FULL_IMAGE_NAME)"
	docker run -d \
			--name $(CONTAINER_NAME)  \
			-p $(PORT_FLASK):5000 \
			-p $(PORT_WIREMOCK):9090 \
			$(FULL_IMAGE_NAME)

#3: stop the Docker container
stop:
	@echo "Stopping Docker container: $(CONTAINER_NAME)"
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true


clean: stop
	@echo "Removing image..."
	docker rmi $(IMAGE_NAME) || true

# 6. Rebuild and Restart (The "I made a change" command)
restart: stop build run
	@echo "Application restarted!"

# 7. Help
help:
	@echo "Usage:"
	@echo "  make build   - Build the Docker image"
	@echo "  make run     - Run the container in the background"
	@echo "  make stop    - Stop and remove the container"
	@echo "  make restart - Stop, Rebuild, and Start again"
	@echo "  make logs    - Follow the container logs"
	@echo "  make clean   - Remove everything (container and image)"


deploy: build run
	@echo "Application deployed and running!"
