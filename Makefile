ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = WAReadMark
WAReadMark_FILES = Tweak.xm
WAReadMark_FRAMEWORKS = UIKit Foundation
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += wareadmarkprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
