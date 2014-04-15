ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = WAReadMarkPrefs
WAReadMarkPrefs_FILES = WAReadMarkPrefs.mm
WAReadMarkPrefs_INSTALL_PATH = /Library/PreferenceBundles
WAReadMarkPrefs_FRAMEWORKS = UIKit
WAReadMarkPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WAReadMarkPrefs.plist$(ECHO_END)
