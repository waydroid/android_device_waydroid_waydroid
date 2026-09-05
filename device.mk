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

ifeq ($(PRODUCT_IS_ATV),true)
# Inherit from atv products.
$(call inherit-product, device/google/atv/products/atv_base.mk)

# Inherit some common ROM stuff
$(call inherit-product-if-exists, vendor/lineage/config/common_full_tv.mk)
else
# Inherit from aosp products.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit some common ROM stuff
$(call inherit-product-if-exists, vendor/lineage/config/common_full_tablet_wifionly.mk)
$(call inherit-product-if-exists, vendor/bliss/config/common_full_tablet_wifionly.mk)
endif

$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)

# Disable compressed APEX
OVERRIDE_PRODUCT_COMPRESSED_APEX := false

# VNDK
# Android 16 deprecates VNDK, but Halium vendors (e.g. Android 14, ro.vndk.version=34)
# still require a matching VNDK APEX. Without it linkerconfig aborts with
# "SANITIZER_DEFAULT_VENDOR is not defined" (missing /apex/com.android.vndk.v34) and
# the container fails to boot. Build the extra VNDK APEX from prebuilts/vndk/v34.
PRODUCT_EXTRA_VNDK_VERSIONS := 34

# Enable automatic partition size
PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

# Audio HAL
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl \
    audio.primary.waydroid \
    audio.r_submix.default \
    audio.usb.default \
    libasound_module_pcm_pulse \
    libasound_module_ctl_pulse \
    libasound_module_conf_pulse

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/manifest_waydroid.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_waydroid.xml \
    $(LOCAL_PATH)/configs/empty_vintf.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest.disabled/empty_vintf.xml \
    $(LOCAL_PATH)/configs/empty_vintf.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest/manifest_host.xml \
    hardware/waydroid/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# Bluetooth HAL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.1-service.sim

# Camera
USE_CAMERA_V4L2_HAL := true

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.7-external-service \
    camera.v4l2

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.composer@2.4-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    vendor.waydroid.task@1.0-service \
    hwcomposer.drm_minigbm \
    hwcomposer.waydroid

PRODUCT_PACKAGES += \
    android.hardware.graphics.common-V4-ndk

ifeq ($(ANDROID_BUILD_REDROID_HWC),true)
PRODUCT_PACKAGES += \
    hwcomposer.redroid
endif

PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle \
    vulkan.pastel

ifneq ($(TARGET_USE_MESA),false)

ifeq ($(filter %_waydroid_x86 %_waydroid_x86_64 %_waydroid_tv_x86 %_waydroid_tv_x86_64,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service.minigbm_dmabuf \
    android.hardware.graphics.mapper@4.0-impl.minigbm_dmabuf \
    gralloc.minigbm_dmabuf
endif

PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0-service.minigbm \
    android.hardware.graphics.allocator@4.0-service.minigbm_gbm_mesa \
    android.hardware.graphics.mapper@4.0-impl.minigbm \
    android.hardware.graphics.mapper@4.0-impl.minigbm_gbm_mesa \
    gralloc.minigbm \
    gralloc.minigbm_gbm_mesa

PRODUCT_PACKAGES += \
    dri_gbm \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libgbm_mesa_wrapper \
    vulkan.lvp \
    vulkan.virtio

ifneq ($(filter %_x86 %_x86_64,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    vulkan.intel \
    vulkan.intel_hasvk \
    vulkan.radeon \
    vulkan.nouveau
else
PRODUCT_PACKAGES += \
    vulkan.freedreno \
    vulkan.broadcom \
    vulkan.panfrost
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml
endif

# DRM
$(call inherit-product, frameworks/av/drm/mediadrm/plugins/clearkey/service-lazy.mk)

# Widevine
ifeq ($(ANDROID_USE_WIDEVINE),true)
$(call inherit-product-if-exists, vendor/google/proprietary/widevine-prebuilt/widevine.mk)
endif

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service \
    gatekeeper.waydroid

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.example \
    android.hardware.health-service.example_recovery

# Init
PRODUCT_PACKAGES += \
    waydroid-init \
    waydroid-preinit

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/init.waydroid.vendor.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.waydroid.vendor.rc

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1-service

# Keymint HAL
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service

# Non-secure implementation of AuthGraph/Secretkeeper HAL for compliance.
PRODUCT_PACKAGES += \
    com.android.hardware.security.authgraph \
    com.android.hardware.security.secretkeeper

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.waydroid

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_c2_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_c2_video.xml

ifneq ($(TARGET_USE_MESA),false)
PRODUCT_COPY_FILES += \
    external/mesa3d/src/util/00-mesa-defaults.conf:$(TARGET_COPY_OUT_VENDOR)/etc/drirc \
    $(LOCAL_PATH)/configs/mediacodec.mesa.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(LOCAL_PATH)/configs/mediacodec.mesa.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaswcodec.policy
endif

ifneq ($(filter %64 %64_only,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/mediaextractor.64bit.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/mediaextractor.32bit.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy
endif

# Media - FFMPEG
PRODUCT_PACKAGES += \
    android.hardware.media.c2-ffmpeg-service

PRODUCT_PROPERTY_OVERRIDES += \
    debug.ffmpeg-codec2.rank=0 \
    debug.ffmpeg-codec2.hwaccel.drm=0 \
    debug.ffmpeg-codec2.pixel_format=RGBX_8888

ifneq ($(filter %_waydroid_x86 %_waydroid_x86_64 %_waydroid_tv_x86 %_waydroid_tv_x86_64,$(TARGET_PRODUCT)),)
# Media - VA-API
PRODUCT_PACKAGES += \
    i965_drv_video \
    iHD_drv_video \
    libgallium_dri

# Media - FFMPEG
PRODUCT_PACKAGES += \
    android.hardware.media.c2-ffmpeg-service \
    vainfo

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.hwaccel=1
endif

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    memtrack.waydroid

# WiFi
PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    wificond \
    wpa_supplicant

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-lineage

ifneq ($(PRODUCT_IS_ATV),true)
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-tablet
endif

# Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/empty_permission.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions.disabled/empty_permission.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.example

# Remove unwanted packages
PRODUCT_PACKAGES += \
    RemovePackages

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-service.waydroid

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Binder IPC
PRODUCT_PACKAGES += \
    vndservicemanager

# Native Bridge
ifeq ($(ANDROID_USE_NDK_TRANSLATION),true)
$(call inherit-product-if-exists, vendor/google/proprietary/ndk_translation-prebuilt/libndk_translation.mk)
$(call inherit-product-if-exists, vendor/google/proprietary/ndk_translation-prebuilt/native_bridge_arm_on_x86.mk)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.nativebridge=1
endif

ifeq ($(ANDROID_USE_INTEL_HOUDINI),true)
$(call inherit-product-if-exists, vendor/intel/proprietary/houdini/houdini.mk)
$(call inherit-product-if-exists, vendor/intel/proprietary/houdini/native_bridge_arm_on_x86.mk)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.nativebridge=1
endif

# Updater
PRODUCT_PACKAGES += \
    WaydroidUpdater

# DocumentsUI
PRODUCT_PACKAGES += \
    DocumentsUI

ifeq ($(PRODUCT_IS_ATV),true)
# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    TvSettings \
    TvSystemUI \
    Catapult

# Keyboard layout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/Generic_ATV.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Generic_ATV.kl

# Fingerprint spoof for GApps
BUILD_FINGERPRINT := google/sabrina_prod_stable/sabrina:12/STTE.240615.007/12033466:user/release-keys
else
# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI \
    Trebuchet \
    TrebuchetQuickStep

# Fingerprint spoof for GApps
BUILD_FINGERPRINT := google/tangorpro/tangorpro:16/BP4A.260205.001/14624666:user/release-keys
endif
