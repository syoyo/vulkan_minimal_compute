#!/bin/bash


rm -rf build
mkdir build

cd build

#cmake ../

# Debug build requires Vulkan ValidationLayers when running the app.
cmake -DCMAKE_BUILD_TYPE=Debug ../

cd ..

