IMAGE?=docker.io/milansimanek/l2tp
# the current tag is stored in "./tag" file
TAG:=$(strip $(shell head -n 1 tag))
TAG_GIT=$(IMAGE):$(TAG)
TAG_LATEST=$(IMAGE):latest

PHONY: all
all: image

PHONY: image
image:
	docker build -t $(TAG_GIT) -f Dockerfile .
	docker tag $(TAG_GIT) $(TAG_LATEST)

PHONY: push
push: image
	docker push $(TAG_GIT)
	docker push $(TAG_LATEST)


clean:
