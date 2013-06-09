/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "DVTToolbarViewController.h"

#import "IDEPathCellDelegate-Protocol.h"
#import "NSPathControlDelegate-Protocol.h"

@class IDENavigableItem, IDENavigableItemCoordinator, IDEPathControl;

@interface IDESchemeToolbarController : DVTToolbarViewController <NSPathControlDelegate, IDEPathCellDelegate>
{
    IDENavigableItemCoordinator *_navigableItemCoordinator;
    IDENavigableItem *_rootNavigable;
    IDEPathControl *_pathControl;
}

+ (id)keyPathsForValuesAffectingPathControlIsEnabled;
+ (id)keyPathsForValuesAffectingSelectedNavigable;
- (void)_editActiveContextAction:(id)arg1;
- (void)_manageContextsAction:(id)arg1;
- (void)_newContextAction:(id)arg1;
- (void)_openMoreSimulators:(id)arg1;
- (void)_windowWillClose:(id)arg1;
- (id)_workspace;
- (id)_workspaceTabController;
- (void)didUpdateRunDestinationMenu:(id)arg1;
- (void)didUpdateSchemeMenu:(id)arg1;
- (id)initWithToolbarItemIdentifier:(id)arg1 window:(id)arg2;
- (void)loadView;
- (struct CGSize)maxSize;
- (struct CGSize)minSize;
- (id)pathCell:(id)arg1 accessibilityDescriptionForPathComponentCell:(id)arg2 atIndex:(unsigned long long)arg3;
- (void)pathCell:(id)arg1 didUpdateMenu:(id)arg2;
- (id)pathCellNoSelectionTitle;
- (BOOL)pathControlIsEnabled;
@property(readonly) IDENavigableItem *rootNavigable; // @synthesize rootNavigable=_rootNavigable;
@property IDENavigableItem *selectedNavigable;
- (BOOL)validateUserInterfaceItem:(id)arg1;

@end

