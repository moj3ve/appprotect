include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = appprotect

appprotect_FILES = CAPRootListController.m
appprotect_INSTALL_PATH = /Library/PreferenceBundles
appprotect_FRAMEWORKS = UIKit
appprotect_PRIVATE_FRAMEWORKS = Preferences
appprotect_CFLAGS = -fobjc-arc
appprotect_LIBRARIES = applist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/appprotect.plist$(ECHO_END)
