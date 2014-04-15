#import <Preferences/Preferences.h>

@interface WAReadMarkPrefsListController: PSListController {
}
@end

@implementation WAReadMarkPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"WAReadMarkPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
