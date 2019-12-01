cmake_minimum_required (VERSION 3.8)
project (vulkan_minimal_compute)

find_package(Vulkan)

# get rid of annoying MSVC warnings.
add_definitions(-D_CRT_SECURE_NO_WARNINGS)

set (CMAKE_CXX_STANDARD 11)

# Vulkan-loaders
set(VulkanHeaders_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/third_party/Vulkan-Headers/include CACHE INTERNAL "" FORCE)
set(VulkanRegistry_DIR ${PROJECT_SOURCE_DIR}/third_party/Vulkan-Headers/registry CACHE INTERNAL "" FORCE)
set(BUILD_WSI_XCB_SUPPORT OFF CACHE INTERNAL "" FORCE)
set(BUILD_WSI_XLIB_SUPPORT OFF CACHE INTERNAL "" FORCE)
set(BUILD_WSI_WAYLAND_SUPPORT oFF CACHE INTERNAL "" FORCE)
add_subdirectory(${PROJECT_SOURCE_DIR}/third_party/Vulkan-Loader)

add_subdirectory(${PROJECT_SOURCE_DIR}/third_party/swiftshader)

set(Vulkan_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/third_party/Vulkan-Headers/include)
include_directories(${Vulkan_INCLUDE_DIR})

#set(ALL_LIBS  ${Vulkan_LIBRARY} )

add_executable(vulkan_minimal_compute src/main.cpp src/lodepng.cpp)

set_target_properties(vulkan_minimal_compute PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}")

# Use Vulkan-Loader's libvulkan
target_link_libraries(vulkan_minimal_compute vulkan )
