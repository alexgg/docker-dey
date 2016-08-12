FROM aggurio/dey-base:dey-2.0-r3

MAINTAINER Alex Gonzalez <alex.gonzalez@digi.com>

ENV HOME="/home/dey"

# Create project
RUN mkdir -p ${HOME}/workspace/ccimx6sbc && cd ${HOME}/workspace/ccimx6sbc && source /usr/local/dey-2.0/mkproject.sh -p ccimx6sbc <<< "y"

WORKDIR ${HOME}/workspace/ccimx6sbc

# Configure local.conf file
RUN echo 'INHERIT += "rm_work"' >> ${HOME}/workspace/ccimx6sbc/conf/local.conf && echo 'DISTRO_FEATURES_remove = "x11"' >> ${HOME}/workspace/ccimx6sbc/conf/local.conf

# Build default image
RUN source ${HOME}/workspace/ccimx6sbc/dey-setup-environment && bitbake dey-image-qt && rm -Rf downloads tmp

# Create project
RUN mkdir -p ${HOME}/workspace/ccimx6ulstarter && cd ${HOME}/workspace/ccimx6ulstarter && source /usr/local/dey-2.0/mkproject.sh -p ccimx6ulstarter <<< "y"

WORKDIR ${HOME}/workspace/ccimx6ulstarter

# Configure local.conf file
RUN echo 'INHERIT += "rm_work"' >> ${HOME}/workspace/ccimx6ulstarter/conf/local.conf

# Build default image
RUN source ${HOME}/workspace/ccimx6ulstarter/dey-setup-environment && bitbake core-image-base && rm -Rf downloads tmp


