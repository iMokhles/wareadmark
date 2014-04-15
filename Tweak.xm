#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define PREFERENCES_PATH @"/var/mobile/Library/Preferences/com.imokhles.WAReadMarkPrefs.plist"
#define PREFERENCES_CHANGED_NOTIFICATION "com.imokhles.WAReadMarkPrefs.preferences-changed"
#define PREFERENCES_ENABLED_READ_KEY @"readMark"

static BOOL readMark = NO;

%hook XMPPConnection

-(void)sendDeliveryReceiptAck:(id)fp8 {
    if (readMark) {
        return; // <-- disabled read ack
    } else {
        return %orig;
    }
}

-(void)sendDeliveryReceiptsForChatMessages:(id)fp8 {
    if (readMark) {
        return; // <-- disabled read for ChatMessages
    } else {
        return %orig;
    }
}

-(void)internalSendDeliveryReceiptsForStanzas:(id)fp8 {
    if (readMark) {
        return; // <-- disabled read for Stanzas
    } else {
        return %orig;
    }
}
%end

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    system("killall WhatsApp");
    NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:PREFERENCES_PATH];
    
    readMark = [preferences[PREFERENCES_ENABLED_READ_KEY] boolValue];
}

%ctor {
    
    NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:PREFERENCES_PATH];
    if (preferences == nil) {
        preferences = @{ PREFERENCES_ENABLED_READ_KEY : @(YES) };
        [preferences writeToFile:PREFERENCES_PATH atomically:YES];
        
        readMark = YES;
        
    } else {
        readMark = [preferences[PREFERENCES_ENABLED_READ_KEY] boolValue];
    }
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PreferencesChangedCallback, CFSTR(PREFERENCES_CHANGED_NOTIFICATION), NULL, CFNotificationSuspensionBehaviorCoalesce);
}