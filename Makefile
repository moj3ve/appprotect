INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = appprotect

appprotect_FILES = Tweak.xm
appprotect_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += appprotect
include $(THEOS_MAKE_PATH)/aggregate.mk
