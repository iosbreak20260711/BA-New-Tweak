# Makefile
THEOS_DEVICE_IP = localhost
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BABypass
BABypass_FILES = Tweak.xm fishhook.c
BABypass_FRAMEWORKS = Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
