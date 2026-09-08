#
# Copyright (C) 2021 The Waydroid Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

-include device/waydroid/waydroid/BoardConfig.mk

# Architecture
TARGET_CPU_ABI := x86_64
TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64

TARGET_2ND_CPU_ABI :=
TARGET_2ND_CPU_ABI2 :=
TARGET_2ND_CPU_VARIANT :=
TARGET_2ND_ARCH :=
TARGET_2ND_ARCH_VARIANT :=

AUDIOSERVER_MULTILIB := first

# Native bridge architecture
TARGET_NATIVE_BRIDGE_ABI := arm64-v8a
TARGET_NATIVE_BRIDGE_ARCH := arm64
TARGET_NATIVE_BRIDGE_ARCH_VARIANT := armv8-a
TARGET_NATIVE_BRIDGE_CPU_VARIANT := generic

# Fingerprint spoof for GApps
BUILD_FINGERPRINT := google/tangorpro/tangorpro:16/BP4A.260205.001/14624666:user/release-keys

ifneq ($(TARGET_USE_MESA),false)
# Trimmed to the desktop hosts we test on (Intel gen9+), plus a software
# fallback. virgl/virtio are for the virtio-gpu render node in the PDK VM.
# The stock x86_64 board also adds i915/crocus/svga/radeonsi and amd/nouveau.
BOARD_MESA3D_GALLIUM_DRIVERS := llvmpipe iris zink virgl
BOARD_MESA3D_VULKAN_DRIVERS := intel swrast virtio
BOARD_MESA3D_GALLIUM_VA := disabled
BOARD_MESA3D_VIDEO_CODECS := all
endif
