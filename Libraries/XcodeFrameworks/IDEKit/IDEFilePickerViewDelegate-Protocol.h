/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject-Protocol.h"

@protocol IDEFilePickerViewDelegate <NSObject>

@optional
- (BOOL)filePickerView:(id)arg1 outlineView:(id)arg2 isItemExpandable:(id)arg3;
- (id)filePickerView:(id)arg1 outlineView:(id)arg2 toolTipForCell:(id)arg3 rect:(struct CGRect *)arg4 tableColumn:(id)arg5 item:(id)arg6 mouseLocation:(struct CGPoint)arg7;
- (void)filePickerView:(id)arg1 outlineView:(id)arg2 willDisplayCell:(id)arg3 forTableColumn:(id)arg4 item:(id)arg5;
@end

