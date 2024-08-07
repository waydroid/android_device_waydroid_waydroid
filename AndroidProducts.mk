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

VENDOR_NAME := aosp
ifneq ("$(wildcard vendor/lineage/*)","")
    VENDOR_NAME := lineage
else ifneq ("$(wildcard vendor/bliss/*)","")
    VENDOR_NAME := bliss
endif

PRODUCT_MAKEFILES := \
    $(VENDOR_NAME)_waydroid_arm64:$(LOCAL_DIR)/waydroid_arm64/$(VENDOR_NAME)_waydroid_arm64.mk \
    $(VENDOR_NAME)_waydroid_arm64_only:$(LOCAL_DIR)/waydroid_arm64_only/$(VENDOR_NAME)_waydroid_arm64_only.mk \
    $(VENDOR_NAME)_waydroid_arm:$(LOCAL_DIR)/waydroid_arm/$(VENDOR_NAME)_waydroid_arm.mk \
    $(VENDOR_NAME)_waydroid_x86:$(LOCAL_DIR)/waydroid_x86/$(VENDOR_NAME)_waydroid_x86.mk \
    $(VENDOR_NAME)_waydroid_x86_64:$(LOCAL_DIR)/waydroid_x86_64/$(VENDOR_NAME)_waydroid_x86_64.mk \
    $(VENDOR_NAME)_waydroid_atv_x86_64:$(LOCAL_DIR)/waydroid_x86_64/$(VENDOR_NAME)_waydroid_atv_x86_64.mk

COMMON_LUNCH_CHOICES := \
    $(VENDOR_NAME)_waydroid_arm64-user \
    $(VENDOR_NAME)_waydroid_arm64-userdebug \
    $(VENDOR_NAME)_waydroid_arm64-eng \
    $(VENDOR_NAME)_waydroid_arm64_only-user \
    $(VENDOR_NAME)_waydroid_arm64_only-userdebug \
    $(VENDOR_NAME)_waydroid_arm64_only-eng \
    $(VENDOR_NAME)_waydroid_arm-user \
    $(VENDOR_NAME)_waydroid_arm-userdebug \
    $(VENDOR_NAME)_waydroid_arm-eng \
    $(VENDOR_NAME)_waydroid_x86-user \
    $(VENDOR_NAME)_waydroid_x86-userdebug \
    $(VENDOR_NAME)_waydroid_x86-eng \
    $(VENDOR_NAME)_waydroid_x86_64-user \
    $(VENDOR_NAME)_waydroid_x86_64-userdebug \
    $(VENDOR_NAME)_waydroid_x86_64-eng \
    $(VENDOR_NAME)_waydroid_atv_x86_64-user \
    $(VENDOR_NAME)_waydroid_atv_x86_64-userdebug \
    $(VENDOR_NAME)_waydroid_atv_x86_64-usereng
