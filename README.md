# Vulkan Minimal Compute

This is a simple demo that demonstrates how to use Vulkan for compute operations only.
In other words, this demo does nothing related to graphics, 
and only uses Vulkan to execute some computation on the GPU.
For this demo, Vulkan is used to render the Mandelbrot set on the GPU. The demo is very simple, 
and is only ~400LOC. **The code is heavily commented, so it should be useful for people interested in learning Vulkan**.

The only depdendencies are Vulkan and `lodepng`. `lodepng` is simply used for png encoding. Vulkan can be installed
from `lunarg.com`

![](image.png)

# Demo

The application launches a compute shader that renders the mandelbrot set, by rendering it into a storage buffer.
The storage buffer is then read from the GPU, and saved as `.png`. Check the source code comments
for further info.

## Building

The project uses CMake, and all dependencies are included, so you
should use CMake to generate a "Visual Studio Solution"/makefile,
and then use that to compile the program. If you then run the program,
a file named `mandelbrot.png` should be created. This is a Mandelbrot
set that has been rendered by using Vulkan. 

## Building with SwiftShader

Assume Linux environment.

```
$ git submodule update --init --recursive
$ ./scripts/bootstrap-linux.sh
$ cd build
$ make
```

### Run with SwiftShader

Put built `vk_swiftshader_icd.json` and `libvk_swiftshader.so` to the root dir of this repo, then:

```
$ export VK_ICD_FILENAMES=vk_swiftshader_icd.json
$ ./build/vulkan_minimal_compute
```

You may need to add `.` to `LD_LIBRARY_PATH` variable.

### Building Vulan-ValidationLayers

SwiftShader and Vulkan-Loader itself does not include Validation Layers implementation.
To use Vulkan-ValidatonLayers, you can build it using 

```
$ ./scripts/build-validation-layers-linux.sh
```

glslang and Vulkan-ValidationLayers will be built into `dist` directory.

Then, set `VK_LAYER_PATH` and `VK_INSTANCE_LAYERS` and run vulkan app.

Also, you need to add path to validation layer .so folder(`dist/lib/`) through `LD_LIBRARY_PATH`.

Example setting is like this(do this in the root dir of this repo).

```
$ export VK_LAYER_PATH=`pwd`/dist/share/vulkan/explicit_layer.d/
$ export VK_INSTANCE_LAYERS=VK_LAYER_LUNARG_standard_validation
$ export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/dist/lib

# If you didn't set `VK_ICD_FILENAMES`, set it to use swiftshader.
# export VK_ICD_FILENAMES=vk_swiftshader_icd.json

$ ./build/vulkan_minimal_compute
```
