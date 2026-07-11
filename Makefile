TARGET := iphone:clang:latest:14.0
ARCHS := arm64 arm64e

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = BABypass
BABypass_FILES = Tweak.xm fishhook.c
BABypass_CFLAGS = -fobjc-arc
BABypass_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/library.mk
