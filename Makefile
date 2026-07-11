> 林肯.pkl:
# 目標設定：產生動態庫（非越獄使用）
TARGET := iphone:clang:latest:8.0
ARCHS := arm64 arm64e

# 專案名稱（生成的 dylib 檔案名，可自定義）
PROJECT_NAME := HideDylib

# 原始檔（Tweak.xm + fishhook.c 需在同一目錄下）
HideDylib_FILES := Tweak.xm fishhook.c

# 需鏈接的系統框架（fishhook 需 Foundation？實際上 fishhook 不依賴 Foundation，但保留無妨）
HideDylib_FRAMEWORKS := Foundation

# 如果是 MonkeyDev 或手動注入，不需要額外安裝腳本
# 以下設定僅用於編譯階段
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/library.mk

# 若 fishhook 是以靜態庫提供，可改用下面的方式（將 fishhook.c 加入 FILES 則無需 LIBRARY）
# HideDylib_LIBRARIES := fishhook

> 林肯.pkl:
#ifndef fishhook_h
#define fishhook_h

#include <stddef.h>
#include <mach-o/dyld.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * A structure representing a particular intended rebinding from a symbol
 * name to its replacement
 */
struct rebinding {
    const char *name;
    void       *replacement;
    void      **replaced;
};

/*
 * For each rebinding in rebindings, rebinds references to external,
 * indirect symbols with the specified name to instead point at
 * replacement for each image in the calling process.
 *
 * Argument rebindings is a pointer to an array of rebinding structures.
 * Argument rebindings_nel is the number of rebinding structures in the
 * array.
 */
int rebind_symbols(struct rebinding rebindings[], size_t rebindings_nel);

/*
 * Rebinds as above, but only in the specified image. The header should
 * point to the mach header of the image to rebind.
 */
int rebind_symbols_image(void *header,
                         intptr_t slide,
                         struct rebinding rebindings[],
                         size_t rebindings_nel);

#ifdef __cplusplus
}
#endif

#endif /* fishhook_h */
