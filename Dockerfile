ARG DEY_BASE_TAG="latest"
FROM aggurio/dey-base:$DEY_BASE_TAG

MAINTAINER Alex Gonzalez <alex.gonzalez@digi.com>

ENV DEY_BUILD_DIR="/home/dey/workspace"
ARG DEY_PLATFORM="ccimx6ulsbc"
ARG DEY_TARGET_IMAGES="dey-image-qt"
ARG DISTRO_FEATURES_REMOVE=""
ENV DL_DIR="/home/dey/downloads"
ENV SSTATE_DIR="/home/dey/sstate-dir"

COPY entrypoint.sh /usr/local/bin/

WORKDIR ${DEY_BUILD_DIR}
USER dey

ENV DEY_PLATFORM=$DEY_PLATFORM
ENV DEY_TARGET_IMAGES=$DEY_TARGET_IMAGES
ENV DISTRO_FEATURES_REMOVE=$DISTRO_FEATURES_REMOVE
ENTRYPOINT ["entrypoint.sh"]
