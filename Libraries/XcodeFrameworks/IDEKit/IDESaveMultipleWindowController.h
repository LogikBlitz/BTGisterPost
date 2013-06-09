/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSWindowController.h"

@class NSArrayController, NSString, NSTableView;

@interface IDESaveMultipleWindowController : NSWindowController
{
    NSArrayController *documentArrayController;
    NSTableView *tableView;
    NSString *_title;
    BOOL _hasDontSaveButton;
    BOOL _hasCancelButton;
    NSString *_cancelButtonTitle;
}

- (id)_openWindowTerminationDisablingReason;
- (void)cancelAction:(id)arg1;
@property(copy) NSString *cancelButtonTitle; // @synthesize cancelButtonTitle=_cancelButtonTitle;
- (void)dontSaveAction:(id)arg1;
@property BOOL hasCancelButton; // @synthesize hasCancelButton=_hasCancelButton;
@property BOOL hasDontSaveButton; // @synthesize hasDontSaveButton=_hasDontSaveButton;
- (id)init;
- (void)runWithEditorDocuments:(id)arg1 callbackBlock:(id)arg2;
- (void)saveAction:(id)arg1;
@property(copy) NSString *title; // @synthesize title=_title;
- (BOOL)tableView:(id)arg1 shouldSelectRow:(long long)arg2;
- (BOOL)tableView:(id)arg1 shouldTrackCell:(id)arg2 forTableColumn:(id)arg3 row:(long long)arg4;
- (void)windowWillClose:(id)arg1;

@end

