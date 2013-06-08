//
//  LoginWindowController.m
//  BTGisterPost
//
//  Copyright (c) 2013 Thomas Blitz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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
