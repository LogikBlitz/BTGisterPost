/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "DVTViewController.h"

#import "IDESnapshotConfirmationDelegate-Protocol.h"

@class IDEWorkspace, NSImage, NSString, NSWindow;

@interface IDESnapshotAreYouSureController : DVTViewController <IDESnapshotConfirmationDelegate>
{
    NSWindow *_hostWindow;
    id _completionBlock;
    IDEWorkspace *_workspace;
    NSWindow *_sheetWindow;
    NSImage *_snapshotImage;
    NSString *_projectOrWorkspaceCapitalized;
    NSString *_operationName;
    BOOL _shouldTakeSnapshot;
}

+ (id)defaultViewNibName;
- (void)_sheetDidEnd;
- (id)initUsingDefaultNib;
- (id)messageDescription;
- (id)messageTitle;
- (void)requestSnapshotConfirmationForOperationName:(id)arg1 inWorkspace:(id)arg2 completionBlock:(id)arg3;
- (void)skipSnapshot:(id)arg1;
- (void)takeSnapshot:(id)arg1;

@end
