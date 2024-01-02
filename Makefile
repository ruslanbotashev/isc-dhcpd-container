# Docker image name and tag
IMAGE_NAME := miver/dhcpd
IMAGE_TAG := latest

# Docker build command
build:
    docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

# Default target
all: build
