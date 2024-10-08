# Build stage
FROM alpine:20240606 AS build

# Install necessary packages
RUN apk add --no-cache build-base cmake

# Set the working directory
WORKDIR /app

# Copy the source code into the container
COPY . /app/libfec

# Build LibFEC
WORKDIR /app/libfec
RUN cmake -S . -B build && \
    cmake --build build && \
    cmake --build build --target test_correctness && \
    cmake --install build

# Release stage
FROM alpine:20240606 AS release

# Copy the build artifacts from the build stage
COPY --from=build /usr/local /usr/local


