.PHONY: all clean deps fmt vet test docker

EXECUTABLE ?= registry-bench

IMAGE ?= registry-bench
COMMIT ?= $(shell git rev-parse --short HEAD)

LDFLAGS = -X "main.build=$(COMMIT)"
PACKAGES = $(shell go list ./... | grep -v /vendor/)

build:
	go build -ldflags '-s -w $(LDFLAGS)'

docker:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags '-s -w $(LDFLAGS)'
	docker build --rm -t $(IMAGE) .


