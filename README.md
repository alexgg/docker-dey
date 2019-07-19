# Digi Embedded Yocto docker builder image

*docker-dey* is a docker image of a pre-compiled Digi Embedded Yocto project.

Digi Embedded Yocto is [Digi International's](http://www.digi.com/) professional embedded Yocto development environment to use with [Digi's embedded product range](http://www.digi.com/products/embedded-systems).

This docker image is not an official Digi product.

To run on a Ubuntu system,

## Install docker
```
sudo apt-get install -y docker.io
```

For convenience, link docker.io to docker: 
```
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
```

## Build the container

```
docker build --build-arg DEY_BASE_TAG=$DEY_VERSION \
 --build-arg DEY_PLATFORM=$DEY_PLATFORM \
 --build-arg DEY_TARGET_IMAGES=$DEY_TARGET_IMAGES \
 --build-arg DISTRO_FEATURES_REMOVE=$DISTRO_FEATURES_REMOVE <Dockerfile>
```

Where the environmental variables are:

* *DEY_VERSION*: The Digi Embedded Yocto version. There should be an aggurio/dey-base tag with the version, for example 2.4.
* *DEY_PLATFORM*: Single platform to build for. Defaults to "ccimx6ulsbc".
* *DEY_TARGET_IMAGES*: One or more target images to build for th given platform. Defaults to "dey-image-qt".
* *DISTRO_FEATURES_REMOVE*: Yocto distro features to remove from the build, which typically depends on the images to build for. Defaults to empty.

Some examples:

To build the default ccimx6ulsbc dey-image-qt image:

```
docker build <Dockerfile>
```

To build core-image-base for the ccimx6ulsbc:

```
DEY_TARGET_IMAGES="core-image-base" \
 DISTRO_FEATURES_REMOVE="x11" \
 docker build \
 --build-arg DEY_TARGET_IMAGES=$DEY_TARGET_IMAGES \
 --build-arg DISTRO_FEATURES_REMOVE=$DISTRO_FEATURES_REMOVE \
 <Dockerfile>
```

To built dey-image-qt-xwayland for the ccimx8x-sbc-pro:

```
DEY_PLATFORM="ccimx8x-sbc-pro" \
 docker build \
 --build-arg DEY_PLATFORM=$DEY_PLATFORM \
 <Dockerfile>
```

To build dey-image-qt-fb for the ccimx8x-sbc-pro:

```
DEY_PLATFORM="ccimx8x-sbc-pro" \
 DISTRO_FEATURES_REMOVE="x11 wayland vulkan" \
 docker build \
 --build-arg DEY_PLATFORM=$DEY_PLATFORM \
 --build-arg DISTRO_FEATURES_REMOVE=$DISTRO_FEATURES_REMOVE \
 <Dockerfile>
```

## Build your project

Once the container image is ready, you can run it with.

```
docker run -it --rm \
--volume ${HOST_BUILD_DIR}:/home/dey/workspace
<container-id>
```

Where HOST_BUILD_DIR is the path to the build directory on the host.

Pre-populated downloads and state-cache directories on the host can be passed
to the container with:

```
sudo docker run -it --rm \
--volume ${HOST_BUILD_DIR}:/home/dey/workspace
--volume ${HOST_DL_DIR}:/home/dey/downloads
--volume ${HOST_STATE_DIR}:/home/dey/sstate-dir
<container-id>
```

