/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "DVTAutoLayoutView.h"

@class DVTGradientImageButton, NSArrayController, NSView;

@interface IDEEditorStepperView : DVTAutoLayoutView
{
    DVTGradientImageButton *_leftArrowButton;
    DVTGradientImageButton *_rightArrowButton;
    NSView *_centerView;
    NSArrayController *_arrayController;
    BOOL _drawRightBorder;
}

+ (id)_arrowButtonWithDirection:(BOOL)arg1;
+ (id)keyPathsForValuesAffectingCanMove;
@property NSArrayController *arrayController; // @synthesize arrayController=_arrayController;
- (BOOL)canMove;
- (struct CGSize)centerViewSizeInHeight:(double)arg1;
- (void)drawRect:(struct CGRect)arg1;
@property BOOL drawRightBorder; // @synthesize drawRightBorder=_drawRightBorder;
- (id)initWithFrame:(struct CGRect)arg1;
- (void)layoutBottomUp;
- (id)newCenterView;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)selectNext:(id)arg1;
- (void)selectPrevious:(id)arg1;
- (void)setGradientStyle:(int)arg1;

@end

