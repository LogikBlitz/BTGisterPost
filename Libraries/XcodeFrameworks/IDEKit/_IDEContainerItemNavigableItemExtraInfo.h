/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import <IDEKit/_IDENavigableItemExtraInfo.h>

@class NSMapTable;

@interface _IDEContainerItemNavigableItemExtraInfo : _IDENavigableItemExtraInfo
{
    NSMapTable *_observersByModelObjectGraph;
}

@property(readonly) NSMapTable *_observersByModelObjectGraph; // @synthesize _observersByModelObjectGraph;
- (void)configureObservingForModelObjectGraph:(id)arg1;
- (id)init;
- (void)processModelObjectGraphNotification:(id)arg1;

@end

