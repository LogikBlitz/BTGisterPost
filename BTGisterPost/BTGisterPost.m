//
//  BTGisterPost.m
//  BTGisterPost
//
//  Created by Thomas Blitz on 07/06/13.
//    Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import "BTGisterPost.h"
#include "GisterPostWindowController.h"
#include "UserCredential.h"

@interface BTGisterPost ()

@property (nonatomic, retain) UserCredential *userCredential;
@property (nonatomic, retain) GisterPostWindowController *gistPostController;

@end


@implementation BTGisterPost


+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static id sharedPlugin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPlugin = [[self alloc] init];
    });
}

- (id)init {
	if (self = [super init]) {
        _gistPostController = [[GisterPostWindowController alloc]init];
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
	}
	return self;
}
- (void) applicationDidFinishLaunching: (NSNotification*) notification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectionDidChange:)
                                                 name:NSTextViewDidChangeSelectionNotification
                                               object:nil];
    
    NSMenuItem* editMenuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (editMenuItem) {
        [[editMenuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem* newMenuItem = [[NSMenuItem alloc] initWithTitle:@"Post Gist to GitHub"
                                                             action:@selector(postGistToGitHub)
                                                      keyEquivalent:@"c"];
        [newMenuItem setTarget:self];
        [newMenuItem setKeyEquivalentModifierMask: NSAlternateKeyMask];
        [[editMenuItem submenu] addItem:newMenuItem];
        [newMenuItem release];
    }
}

- (void) selectionDidChange: (NSNotification*) notification {
    if ([[notification object] isKindOfClass:[NSTextView class]]) {
        NSTextView* textView = (NSTextView *)[notification object];
        
        NSArray* selectedRanges = [textView selectedRanges];
        
        NSRange selectedRange = [[selectedRanges objectAtIndex:0] rangeValue];
        NSString* text = textView.textStorage.string;
        self.selectedText = [text substringWithRange:selectedRange];
        
        if (!self.selectedText || [self.selectedText isEqualToString:@""]){
            self.selectedText = textView.textStorage.string;
        }
        

    }
}

- (void) showMessageBox: (id) origin {
    
    [self.gistPostController showGistDialogWindowWithGistText:self.selectedText];
}

- (void) postGistToGitHub{    
    [self.gistPostController showGistDialogWindowWithGistText:self.selectedText];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.gistPostController = nil;
    [self.gistPostController dealloc];
    
    [super dealloc];
}

@end
