/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

@interface IDECommandManager : NSObject
{
}

+ (SEL)_actionForCommandWithIdentifier:(id)arg1;
+ (id)_commandDefinitionIdentifierForSelector:(SEL)arg1;
+ (id)_commandExtensionForIdentifier:(id)arg1;
+ (void)cacheCommandDefinitionsAndHandlers;
+ (id)handlerForAction:(SEL)arg1 withSelectionSource:(id)arg2;
+ (void)initialize;
+ (void)sendActionForCommandWithIdentifier:(id)arg1 from:(id)arg2;

@end

