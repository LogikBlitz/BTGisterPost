//
//  GisterPostWindowController.m
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

#import "GisterPostWindowController.h"
#import "BTGitHubEngine.h"
#import "LoginWindowController.h"
#import "Gist.h"


@interface GisterPostWindowController ()
@property (nonatomic, retain) BTGitHubEngine *githubEngine;
@property (nonatomic, retain) NSUserNotificationCenter *notificationCenter;
@property (nonatomic, retain) LoginWindowController *loginWindowController;
@end

@implementation GisterPostWindowController


- (id)init
{
    self = [super init];
    NSLog(@"SELF IS : %@", self);
    if (self) {
        NSLog(@"IN INIT");
        _notificationCenter = [[NSUserNotificationCenter defaultUserNotificationCenter] retain];
        _notificationCenter.delegate = self;
        _loginWindowController = [[[LoginWindowController alloc] initWithDelegate:self]retain];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self.mainWindow center];
	[self.mainWindow makeKeyAndOrderFront:self];
    
}

#pragma mark - LoginProtocol Implementation

- (void)userCancelledLogin{
    [self notifyWithText:@"Gist creation cancelled by user" withTitle:@"XCode Gister" andSubTitle:nil];
    
    [self resignWindow];
}

- (void)credentialCreated:(UserCredential *)credential{
    self.userCredential = credential;
    [self postGist];
}


- (void)requestUserCredentials{    
    [self.loginWindowController showModalLoginViewInWindow:self.mainWindow];
}

- (void)postGist{
    NSError *error = nil;
    [self postGist:self.gistText withDescription:[self.gistDescriptionTextField stringValue] andFilename:[self.fileNameTextField stringValue] andCredential:self.userCredential withError:&error];
    
    if (error) {
        NSAlert *alert = [[[NSAlert alloc] init] retain];
        [alert setMessageText: @"Posting gist failed. Please try again"];
        [alert runModal];
        [alert release];
        return;
    }

}

- (IBAction)CommitGist:(id)sender {
    if (!self.userCredential){
        [self requestUserCredentials];
        
    }else{
        [self postGist];
    }
    
}

- (void)showGistDialogWindowWithGistText:(NSString *)gistText{
    self.gistText = gistText;
    [NSBundle loadNibNamed:@"GisterPostWindow" owner:self];
    
    if (!self.gistText || [self.gistText isEqualToString:@""] ){
        NSAlert *alert = [[[NSAlert alloc] init] retain];
        [alert setMessageText: @"No text was submitted for the gist. Please select the text to turn into a gist."];
        [alert runModal];
        [alert release];
        
        [self CancelCommit:self];
        return;
    }
}


-(BTGitHubEngine *)githubEngine{
    if (!_githubEngine){
        self.githubEngine = [[BTGitHubEngine alloc]initWithUsername:self.userCredential.username password:self.userCredential.password withReachability:YES];
    }
    return _githubEngine;
}


- (void)postGist:(NSString *)gistText withDescription:(NSString *)gistDescription andFilename:(NSString *)filename andCredential:(UserCredential *)credential withError:(NSError **)error{
    
    BOOL isPublic = ![self.privateGistCheckBox state] == NSOnState;
    
    Gist *gist = [[[Gist alloc]initWithGistText:gistText andFilename:filename andDescription:gistDescription isPrivate:isPublic] retain];
    
    [self resignWindow];
    
    [self.githubEngine createGist:[gist gistAsDictionary] success:^(id success) {
        [self notifyWithText:@"Your gist was created and is available on GitHub." withTitle:@"Xcode Gister" andSubTitle:[NSString stringWithFormat:@"%@ Gist Created", gist.filename]];
        
    } failure:^(NSError *error) {
        self.userCredential = nil;
        NSAlert *alert = [[[NSAlert alloc] init] retain];
        [alert setMessageText: @"GitHub could not create the gist. Check your username and password"];
        [alert runModal];
        [alert release];
    }];
    
    [gist release];
}


- (void)resignWindow{
    [self.mainWindow orderOut:self];
}

- (IBAction)CancelCommit:(id)sender {
    [self resignWindow];
}


#pragma mark - User notification OSX 10.8

- (void)notifyWithText:(NSString *)text withTitle:(NSString *)title andSubTitle:(NSString *)subTitle{
    
    NSUserNotification *notification = [[[NSUserNotification alloc]init] retain];
    notification.title = title;
    notification.subtitle = subTitle;
    notification.informativeText = text;
    [self.notificationCenter deliverNotification:notification];
    [notification release];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}


#pragma mark - lifecycle management
- (void)dealloc
{
    self.githubEngine = nil;
    [self.githubEngine dealloc];
    
    self.notificationCenter = nil;
    [self.notificationCenter dealloc];
    
    self.gistText = nil;
    [self.gistText dealloc];
    
    self.userCredential = nil;
    [self.userCredential dealloc];
    
    self.loginWindowController = nil;
    [self.loginWindowController dealloc];
    
    self.mainWindow = nil;
    
    self.privateGistCheckBox = nil;
    
    self.gistDescriptionTextField = nil;
    
    self.fileNameTextField = nil;
    self.commitView = nil;
    
    [super dealloc];
}
@end
