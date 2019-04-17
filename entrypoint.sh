#!/bin/sh

[ ! -w "${DEY_BUILD_DIR}" ] && echo "Specify a host mounted  writable DEY_BUILD_DIR as build argument" && exit 1
echo -n "Building ${DEY_TARGET_IMAGES} for ${DEY_PLATFORM}"

install -o 1000 -g 1000 -d ${DEY_BUILD_DIR}/${DEY_PLATFORM}
cd ${DEY_BUILD_DIR}/${DEY_PLATFORM}

# Create project
if [ ! -f conf/local.conf ]; then
	if [ -t 1 ]; then
		source ${DEY_INSTALL_PATH}/mkproject.sh -p ${DEY_PLATFORM}
	else
		source ${DEY_INSTALL_PATH}/mkproject.sh -p ${DEY_PLATFORM} <<< "y"
	fi

	[ ! -f conf/local.conf ] && exit 1

	# Configure local.conf file
	echo 'INHERIT += "rm_work"' >> ${DEY_BUILD_DIR}/${DEY_PLATFORM}/conf/local.conf &&
	echo "DISTRO_FEATURES_remove = \"${DISTRO_FEATURES_REMOVE}\"" >> ${DEY_BUILD_DIR}/${DEY_PLATFORM}/conf/local.conf &&
	echo "DL_DIR = \"${DL_DIR}\"" >> ${DEY_BUILD_DIR}/${DEY_PLATFORM}/conf/local.conf &&
	echo "SSTATE_DIR = \"${SSTATE_DIR}\"" >> ${DEY_BUILD_DIR}/${DEY_PLATFORM}/conf/local.conf
fi

# Build default images for the defined platform
source ${DEY_BUILD_DIR}/${DEY_PLATFORM}/dey-setup-environment && bitbake ${DEY_TARGET_IMAGES}
