/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSActionCell.h"

@class NSAttributedString, NSImage, NSString;

@interface IDENavigatorStatusCell : NSActionCell
{
    unsigned long long _imageScaling;
    struct CGSize _baseImageSize;
    NSImage *_image;
    NSAttributedString *_attributedStringValue;
    int _statusCellType;
}

+ (void)initialize;
- (void)_clearAttributedStringValue;
- (void)_drawStatusStringInPathRect:(struct CGRect)arg1 view:(id)arg2;
- (void)_validateCachedAttributedStringValue;
- (id)attributedStringValue;
@property struct CGSize baseImageSize; // @synthesize baseImageSize=_baseImageSize;
- (struct CGSize)cellSize;
- (void)drawCharacterStatusWithFrame:(struct CGRect)arg1 inView:(id)arg2;
- (void)drawImageStatusWithFrame:(struct CGRect)arg1 inView:(id)arg2;
- (void)drawInteriorWithFrame:(struct CGRect)arg1 inView:(id)arg2;
- (void)drawTextStatusWithFrame:(struct CGRect)arg1 inView:(id)arg2;
- (id)dvtExtraBindings;
@property NSImage *image; // @synthesize image=_image;
@property unsigned long long imageScaling; // @synthesize imageScaling=_imageScaling;
- (id)initWithType:(int)arg1;
- (void)setHighlighted:(BOOL)arg1;
@property(copy) NSString *title; // @dynamic title;
@property(readonly) int statusCellType; // @synthesize statusCellType=_statusCellType;

@end
