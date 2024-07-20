#!/bin/sh

# Default values
DEFAULT_IMAGE_NAME="libfec-alpine"
DEFAULT_TAG="0.1.0"

# Usage function to display help for the script
usage() {
  echo "Usage: $0 [-n <image-name>] [-t <tag>]"
  exit 1
}

# Parse command-line arguments
while getopts ":n:t:" opt; do
  case ${opt} in
    n )
      IMAGE_NAME=$OPTARG
      ;;
    t )
      TAG=$OPTARG
      ;;
    \? )
      usage
      ;;
    : )
      usage
      ;;
  esac
done

# Set defaults if not provided
IMAGE_NAME=${IMAGE_NAME:-$DEFAULT_IMAGE_NAME}
TAG=${TAG:-$DEFAULT_TAG}

# Build and tag the Docker image
docker build -t "${IMAGE_NAME}:${TAG}" .

# Verify if the image was built successfully
if [ $? -eq 0 ]; then
  echo "Docker image ${IMAGE_NAME}:${TAG} built successfully."
else
  echo "Failed to build Docker image ${IMAGE_NAME}:${TAG}."
  exit 1
fi

