//
//  BTGisterPost.m
//  BTGisterPost
//
//  Created by donkeyfly on 28/08/13.
//    Copyright (c) 2013 donkeyfly. All rights reserved.
//

#import "BTGisterPost.h"
#import "GitHubUserInfo.h"
#include "GisterPostWindowController.h"


@interface BTGisterPost()

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) GitHubUserInfo *userCredential;
@property (nonatomic, strong) GisterPostWindowController *gistPostController;
@property (nonatomic, strong) NSString *selectedText;

@end

@implementation BTGisterPost


+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static id sharedPlugin = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPlugin = [[self alloc] initWithBundle: plugin];
    });
}

- (id)init
{
    if (self = [super init]) {
        NSLog(@"INIT");
        [self addMenuItems];
    }
    return self;
}

- (id)initWithBundle:(NSBundle *)plugin {
    if (self = [super init]) {
        NSLog(@"INIT WITH PLUGINª");
        _bundle = plugin;
        self.gistPostController = [[GisterPostWindowController alloc]init];
        [self addMenuItems];
        [self registrerForSelectionChanges];
    }
    return self;
}

- (void)addMenuItems {
    NSMenuItem* editMenuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (editMenuItem) {
        [[editMenuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem* newMenuItem = [[NSMenuItem alloc] initWithTitle:@"Post Gist to GitHub"
                                                             action:@selector(postGistToGitHub)
                                                      keyEquivalent:@"c"];
        [newMenuItem setTarget:self];
        [newMenuItem setKeyEquivalentModifierMask: NSAlternateKeyMask];
        [[editMenuItem submenu] addItem:newMenuItem];;
    }

}

- (void)registrerForSelectionChanges{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectionDidChange:)
                                                 name:NSTextViewDidChangeSelectionNotification
                                               object:nil];
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    NSAlert *alert = [NSAlert alertWithMessageText:@"Hello, World" defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
    [alert runModal];
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


- (void) postGistToGitHub{
    [self.gistPostController showGistDialogWindowWithGistText:self.selectedText];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
