/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef LIBINIT_DALVIK_VM_H
#define LIBINIT_DALVIK_VM_H

#include <string>

typedef struct dalvik_vm_info {
    std::string backgroundcpuset;
    std::string backgroundthreads;
    std::string bootcpuset;
    std::string bootcputhreads;
    std::string dexcpuset;
    std::string dexcputhreads;
} dalvik_heap_info_t;

void set_dalvik_heap(void);

#endif // LIBINIT_DALVIK_HEAP_H
