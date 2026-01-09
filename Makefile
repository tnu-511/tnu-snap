TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TalalFalcon
TalalFalcon_FILES = Tweak.x
TalalFalcon_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
