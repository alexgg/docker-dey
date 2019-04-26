ARG DEY_BASE_TAG="latest"
FROM aggurio/dey-base:$DEY_BASE_TAG

MAINTAINER Alex Gonzalez <alex.gonzalez@digi.com>

ENV DEY_BUILD_DIR="/home/dey/workspace"
ARG DEY_PLATFORM="ccimx6ulsbc"
ARG DEY_TARGET_IMAGES="dey-image-qt"
ARG DISTRO_FEATURES_REMOVE=""
ENV DL_DIR="/home/dey/downloads"
ENV SSTATE_DIR="/home/dey/sstate-dir"

ARG WINDOWS=""
COPY entrypoint.sh $DEY_INSTALL_PATH
RUN if [ -z "$WINDOWS" ]; then : ; else dos2unix -n $DEY_INSTALL_PATH/entrypoint.sh /tmp/entrypoint.sh && mv -f /tmp/entrypoint.sh $DEY_INSTALL_PATH/entrypoint.sh ; fi

WORKDIR ${DEY_BUILD_DIR}
USER dey

ENV DEY_PLATFORM=$DEY_PLATFORM
ENV DEY_TARGET_IMAGES=$DEY_TARGET_IMAGES
ENV DISTRO_FEATURES_REMOVE=$DISTRO_FEATURES_REMOVE
ENTRYPOINT $DEY_INSTALL_PATH/entrypoint.sh
