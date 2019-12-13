#!/bin/bash

BUILD_DIR=validation-layers-build

rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}

cd ${BUILD_DIR}

## glslang

### Need to checkout spirv-tools since Vulkan-ValidationLayers requires it.
curdir=`pwd`
cd ../third_party/glslang
python update_glslang_sources.py
cd ${curdir}

mkdir glslang
cd glslang

cmake -DCMAKE_INSTALL_PREFIX=`pwd`/../../dist ../../third_party/glslang

make -j 8 && make install

cd ..

## Vulkan-Headers(just copy files)

mkdir vulkan-headers

cd vulkan-headers

cmake -DCMAKE_INSTALL_PREFIX=`pwd`/../../dist ../../third_party/Vulkan-Headers

make && make install

cd ..

## Vulkan-ValidationLayers

mkdir vulkan-validationlayers

cd vulkan-validationlayers

# Disable windowing system for a while.
cmake  -DCMAKE_INSTALL_PREFIX=`pwd`/../../dist \
  -DVULKAN_HEADERS_INSTALL_DIR=`pwd`/../../dist \
  -DGLSLANG_INSTALL_DIR=`pwd`/../../dist \
  -DBUILD_WSI_XCB_SUPPORT=Off \
  -DBUILD_WSI_XLIB_SUPPORT=Off \
  -DBUILD_WSI_WAYLAND_SUPPORT=Off \
  ../../third_party/Vulkan-ValidationLayers

make -j 8 && make install

cd ..
