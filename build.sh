#!/bin/bash
#===============================================================================
#
#  build.sh
#
#  Copyright (C) 2019 by Digi International Inc.
#  All rights reserved.
#
#  This program is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License version 2 as published by
#  the Free Software Foundation.
#
#
#  !Description: Digi Embedded Yocto autobuild script.
#
#  Parameters:
#     DEY_VERSION: Digi Embedded Yocto revision to build for
#     BUILD_DIR: Path to the writable build directoy
#
#===============================================================================

[ -z "${DEY_VERSION}" ] && echo "DEY_VERSION not specified" && exit 1
[ -z "${BUILD_DIR}" ] && echo "BUILD_DIR not specified" && exit 1

mkdir -p ${BUILD_DIR}/${DEY_VERSION}/downloads/
mkdir -p ${BUILD_DIR}/${DEY_VERSION}/sstate-dir

while read DEY_PLATFORM DEY_TARGET_IMAGES; do
	eval DOCKER_TAG="${DEY_PLATFORM}_${DEY_TARGET_IMAGES}"
	sudo docker build --build-arg DEY_BASE_TAG=$DEY_VERSION \
	--build-arg DEY_PLATFORM=$DEY_PLATFORM \
	--build-arg DEY_TARGET_IMAGES=$DEY_TARGET_IMAGES \
	-t aggurio/docker-dey:${DOCKER_TAG} \
	https://github.com/alexgg/docker-dey.git

	HOST_DL_DIR=${BUILD_DIR}/${DEY_VERSION}/downloads/
	HOST_STATE_DIR=${BUILD_DIR}/${DEY_VERSION}/sstate-dir
	sudo docker run --rm --volume ${BUILD_DIR}/${DEY_VERSION}:/home/dey/workspace \
	--volume ${HOST_DL_DIR}:/home/dey/downloads \
	--volume ${HOST_STATE_DIR}:/home/dey/sstate-dir \
	aggurio/docker-dey:${DOCKER_TAG}
done<<-_EOF
	ccimx6ulsbc         dey-image-qt
	ccimx6ulstarter     core-image-base
	ccimx6sbc           dey-image-qt
	ccimx6qpsbc         dey-image-qt
	ccimx8x-sbc-pro     dey-image-qt
	ccimx8x-sbc-express dey-image-qt
_EOF
