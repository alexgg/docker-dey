# Digi Embedded Yocto docker builder image

*docker-dey* is a docker image of a pre-compiled Digi Embedded Yocto project.

Digi Embedded Yocto is [Digi International's](http://www.digi.com/) professional embedded Yocto development environment to use with [Digi's embedded product range](http://www.digi.com/products/embedded-systems).

This docker image is not an official Digi product.

However, it's a good way to test run a Digi Embedded Yocto release as it provides a ready to use pre-configured and pre-compiled environment.

To run on a Ubuntu system,

## Install docker
`sudo apt-get install -y docker.io`

For convenience, link docker.io to docker: 
`sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker`

## Run the image
`sudo docker run -it --rm aggurio/docker-dey:latest bash`

## Rebuild your project
Digi Embedded Yocto has been installed in **/usr/local/dey-2.0**, with ready to use projects for the supported platforms under **/home/dey/workspace/**.

On login you will be inside a product's project.

To regenerate the images from the shared state cache just do:

`source dey-setup-environment`

and

`bitbake dey-image-qt`
