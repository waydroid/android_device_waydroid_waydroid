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

TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64

ifneq ($(TARGET_USE_MESA),false)
BOARD_MESA3D_GALLIUM_DRIVERS += i915 iris crocus
BOARD_MESA3D_VULKAN_DRIVERS += intel intel_hasvk
BOARD_MESA3D_GALLIUM_VA := enabled
BOARD_MESA3D_VIDEO_CODECS := h264dec h264enc h265dec h265enc vc1dec
endif
