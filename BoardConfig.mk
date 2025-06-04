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

BOARD_VENDOR := waydroid

DEVICE_PATH := device/waydroid/waydroid

# Binder
TARGET_USES_64_BIT_BINDER := true

# APEX
TARGET_FLATTEN_APEX := true

# Platform
TARGET_BOARD_PLATFORM := waydroid

# Init
TARGET_INIT_VENDOR_LIB ?= //$(COMMON_PATH):init_waydroid_waydroid
TARGET_RECOVERY_DEVICE_MODULES ?= init_waydroid_waydroid

# Kernel
TARGET_NO_KERNEL := true

# Audio
USE_XML_AUDIO_POLICY_CONF := 1

# Bootloader
TARGET_NO_BOOTLOADER := true

# Display
TARGET_USES_HWC2 := true
ifneq ($(TARGET_USE_MESA),false)
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_MESON_ARGS := -Dallow-kcmp=enabled -Dintel-clc=system -Dmesa-clc=system -Dprecomp-compiler=system
BOARD_MESA3D_BUILD_LIBGBM := true
BOARD_MESA3D_GALLIUM_DRIVERS := r300 r600 nouveau llvmpipe svga virgl radeonsi zink
BOARD_MESA3D_VULKAN_DRIVERS := swrast virtio amd
endif

# Filesystem
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# HIDL
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Partitions
TARGET_COPY_OUT_VENDOR := vendor
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# Offending entries:
# /system/etc/libnfc-nci.conf
BUILD_BROKEN_DUP_RULES := true

BUILD_BROKEN_VINTF_PRODUCT_COPY_FILES := true
