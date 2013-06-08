//
//  LoginWindowController.m
//  BTGisterPost
//
//  Created by Thomas Blitz on 08/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import "LoginWindowController.h"

@interface LoginWindowController ()

@end

@implementation LoginWindowController

- (id)initWithDelegate:(id<LoginProtocol>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}


- (void)alertWithMessage:(NSString *)message{
    if (!self.loginWindow){
        NSAlert *alert = [[[NSAlert alloc] init] retain];
        [alert setMessageText: message];
        [alert runModal];
        [alert release];
    }
}

- (IBAction)loginButtonPushed:(id)sender {
    NSString *username = [[self.usernameTextField stringValue] retain];
    if (!username || [username isEqualToString:@""]){
        [self alertWithMessage:@"You must provide a username"];
        return;
    }
    
    NSString *password = [[self.passwordTextField stringValue] retain];
    if (!password || [password isEqualToString:@""]){
        [self alertWithMessage:@"You must provide a password"];
        return;
    }
    
    [self closeModelWindow:self];
    
    UserCredential *credential = [[[UserCredential alloc]initWithUsernam:username andPassword:password] retain];
    
    [self.delegate credentialCreated:credential];
     
    [username release];
    [password release];
    [credential release];  
}

- (IBAction)cancelButtonPushed:(id)sender {
    [self closeModelWindow:self];
    
    if ([self.delegate respondsToSelector:@selector(userCancelledLogin)]){
        [self.delegate userCancelledLogin];
    }
}

- (void)showModalLoginViewInWindow:(NSWindow *)window{
    [NSBundle loadNibNamed:@"LoginWindow" owner:self];
    
    if (!self.loginWindow){
        [self alertWithMessage:@"my window was nil. cannot display modal. FATAL bug. report to developer"];
        return;
    }
    
    [NSApp beginSheet: self.loginWindow
       modalForWindow: window
        modalDelegate: self
       didEndSelector: @selector(didEndSheet:returnCode:contextInfo:)
          contextInfo: nil];
}


- (void)closeModelWindow: (id)sender
{
    [NSApp endSheet:self.loginWindow];
    [self.loginWindow orderOut:self];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    [sheet orderOut:self];
}


- (void)dealloc
{
    self.loginWindow = nil;
    self.usernameTextField = nil;
    self.passwordTextField = nil;
    self.delegate = nil;
    [super dealloc];
}


@end
