/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@interface IDEAlertsMenuDelegate : NSObject
{
}

+ (id)_findMenuItemTitled:(id)arg1 inMenu:(id)arg2;
+ (void)registerMenuKeyBindingsToMenuKeyBindingSet:(id)arg1;
- (void)_buildMenu:(id)arg1;
- (void)_keyBindingDidChangeKeyboardShortcuts:(id)arg1;
- (void)buildMenu:(id)arg1;
- (void)editAlerts:(id)arg1;
- (id)init;
- (void)menuWillOpen:(id)arg1;
- (void)performAlertEvent:(id)arg1;

@end

