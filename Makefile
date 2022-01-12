default: image

image:
	docker pull centos:7
	docker build . \
		--file Dockerfile \
		--build-arg BUILDER_IMAGE=neubauergroup/centos-python3:3.9.9 \
		--build-arg CMAKE_VERSION=3.20.2 \
		--tag neubauergroup/centos-build-base:debug-local
