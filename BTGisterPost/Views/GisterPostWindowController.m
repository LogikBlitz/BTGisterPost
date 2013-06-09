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
#import "Reachability.h"
#import "NSAlert+EasyAlert.h"
#import <IDEKit/IDEWorkspaceWindowController.h>
#import <IDEKit/IDEEditorArea.h>

id objc_getClass(const char* name);

static Class DVTSourceTextViewClass;
static Class IDESourceCodeEditorClass;
static Class IDEApplicationClass;
static Class IDEWorkspaceWindowControllerClass;


@interface GisterPostWindowController ()
@property (nonatomic, retain) id ideWorkspaceWindow;
@property (nonatomic, retain) BTGitHubEngine *githubEngine;
@property (nonatomic, retain) NSUserNotificationCenter *notificationCenter;
@property (nonatomic, retain) LoginWindowController *loginWindowController;
@end

@implementation GisterPostWindowController
+(BOOL)checkNet{
    
    Reachability *netStatus=[Reachability reachabilityWithHostname:@"www.google.com"];
    
    if ([netStatus currentReachabilityStatus] == IsNotReachable){
        return NO;
    }
    return YES;
}

#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        _notificationCenter = [[NSUserNotificationCenter defaultUserNotificationCenter] retain];
        _notificationCenter.delegate = self;
        _loginWindowController = [[[LoginWindowController alloc] initWithDelegate:self]retain];
        DVTSourceTextViewClass = objc_getClass("DVTSourceTextView");
        IDESourceCodeEditorClass = objc_getClass("IDESourceCodeEditor");
        IDEApplicationClass = objc_getClass("IDEApplication");
        IDEWorkspaceWindowControllerClass = objc_getClass("IDEWorkspaceWindowController");
        
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(fetchActiveIDEWorkspaceWindow:)
                   name:NSWindowDidUpdateNotification
                 object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
    
    self.ideWorkspaceWindow = nil;
    [self.ideWorkspaceWindow dealloc];
    
    self.mainWindow = nil;
    
    self.privateGistCheckBox = nil;
    
    self.gistDescriptionTextField = nil;
    
    self.fileNameTextField = nil;
    self.commitView = nil;
    
    [super dealloc];
}

#pragma mark - Helper
- (NSURL *)activeDocument
{
    for (id workspaceWindowController in [IDEWorkspaceWindowControllerClass workspaceWindowControllers])
    {
        if ([workspaceWindowController workspaceWindow] == self.ideWorkspaceWindow)
        {
            return [[[workspaceWindowController editorArea] primaryEditorDocument] fileURL];
        }
    }
    
    return nil;
}

- (NSString *)currentDocumentName{
    NSURL *activeDocumentURL = [self activeDocument];
    NSString *activeDocumentFilename = [activeDocumentURL lastPathComponent];
    
    return activeDocumentFilename;
}

- (void)defineFirstReponderTextField{
    if(!self.fileNameTextField || [self.fileNameTextField.stringValue isEqualToString:@""]){
        [[self.fileNameTextField window]makeFirstResponder:self.fileNameTextField];
    }else{
        [[self.gistDescriptionTextField window]makeFirstResponder:self.gistDescriptionTextField];
    }
}


#pragma mark - LoginProtocol Implementation

- (void)userCancelledLogin{
    [self makeWindowSolid];
}

- (void)credentialCreated:(UserCredential *)credential{
    [self makeWindowSolid];
    self.userCredential = credential;
    [self postGist];
}


#pragma mark - View management
- (void)windowDidLoad
{
    [super windowDidLoad];
    
	[self.mainWindow makeKeyAndOrderFront:self];
    [self makeWindowSolid];
}

- (void)resignWindow{
    [self.mainWindow orderOut:self];
}


#pragma mark - View transparancy

- (void)dimWindow{
    [[self.mainWindow animator] setAlphaValue:0.3f];
}

- (void)makeWindowSolid{
    [[self.mainWindow animator] setAlphaValue:1.0f];
    [self.fileNameTextField becomeFirstResponder];
}

- (void)makeWindowInvisible{
    [[self.mainWindow animator] setAlphaValue:0.0f];
}

#pragma mark - Gist handeling

- (void)requestUserCredentials{
    [self dimWindow];
    [self.loginWindowController showModalLoginViewInWindow:self.mainWindow];
}

- (void)postGist{
    
    [self makeWindowInvisible];
    [self postGist:self.gistText withDescription:[self.gistDescriptionTextField stringValue] andFilename:[self.fileNameTextField stringValue] andCredential:self.userCredential success:^(Gist *gist) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self resignWindow];
                           [self notifyWithText:@"Your gist was created and is available on GitHub." withTitle:@"Xcode Gister" andSubTitle:[NSString stringWithFormat:@"%@ Gist Created", gist.filename]];
                           NSLog(@"BTGisterPost Message: %@ Gist Created", gist.filename);
                       });
        
        
    } andFailure:^(NSString *errorMessage) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self resetController];
                           [self makeWindowSolid];
                           [self showAlertSheetWithMessage:@"Gist not created" additionalInfo:errorMessage buttonOneText:@"OK" buttonTwoText:nil attachedToWindow:self.mainWindow withSelector:@selector(sheetDidEndShouldDelete:returnCode:contextInfo:)];
                       }
                       );
        
    }];
}

- (void)commitGist{
    if (!self.userCredential){
        [self requestUserCredentials];
        
    }else{
        [self postGist];
    }
    
}


//Only public method
- (void)showGistDialogWindowWithGistText:(NSString *)gistText{
    self.gistText = gistText;
    NSString *filename =[self currentDocumentName];
    if (!self.gistText || [self.gistText isEqualToString:@""] ){
        NSRunAlertPanel(@"No Gist text selected", @"No text was submitted for the gist. Please select the text to turn into a gist.", @"OK", nil, nil, nil);
        [self resignWindow];
        return;
    }
    [NSBundle loadNibNamed:@"GisterPostWindow" owner:self];
    
    
    
    [self.mainWindow makeKeyAndOrderFront:self];
    [self.fileNameTextField setStringValue:filename];
    [self defineFirstReponderTextField];
}

- (void)resetController{
    self.githubEngine = nil;
    self.userCredential = nil;
}

- (void)postGist:(NSString *)gistText withDescription:(NSString *)gistDescription andFilename:(NSString *)filename andCredential:(UserCredential *)credential success:(void (^)(Gist *gist))successBlock andFailure:(void (^)(NSString * errorMessage))failureBlock{
    
    BOOL isPublic = ![self.privateGistCheckBox state] == NSOnState;
    
    Gist *gist = [[[Gist alloc]initWithGistText:gistText andFilename:filename andDescription:gistDescription isPrivate:isPublic] retain];
    
    dispatch_queue_t workingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(workingQueue,
                   ^{
                       BOOL isOnline = [GisterPostWindowController checkNet];
                       if (!isOnline){
                           failureBlock(@"Could not connect to GitHub. Check your internet connection");
                       }
                       else{
                           [self.githubEngine createGist:[gist gistAsDictionary] success:^(id success) {
                               successBlock(gist);
                               
                           } failure:^(NSError *gistError) {
                               failureBlock(@"Github could not create the gist. Check username and password");
                           }];
                       }
                   });
    [gist release];
}


- (void)postGist:(NSString *)gistText withDescription:(NSString *)gistDescription andFilename:(NSString *)filename andCredential:(UserCredential *)credential withError:(NSError **)error{
    
    BOOL isPublic = ![self.privateGistCheckBox state] == NSOnState;
    
    Gist *gist = [[[Gist alloc]initWithGistText:gistText andFilename:filename andDescription:gistDescription isPrivate:isPublic] retain];
    
    [self makeWindowInvisible];
    
    [self.githubEngine createGist:[gist gistAsDictionary] success:^(id success) {
        [self resignWindow];
        [self notifyWithText:@"Your gist was created and is available on GitHub." withTitle:@"Xcode Gister" andSubTitle:[NSString stringWithFormat:@"%@ Gist Created", gist.filename]];
        NSLog(@"BTGisterPost Message: %@ Gist Created", gist.filename);
        
    } failure:^(NSError *gistError) {
        *error = gistError;
    }];
    
    [gist release];
}

#pragma mark - Window Actions and outlets
- (IBAction)CancelCommitButtonPushed:(id)sender {
    [self resignWindow];
    
}

- (IBAction)CommitGistButtonPushed:(id)sender {
    [self commitGist];
}

- (IBAction)fileNameTextFieldEnterPushed:(id)sender{
    [self commitGist];
}

- (IBAction)descriptionTextFieldEnterPushed:(id)sender{
    [self commitGist];
}

#pragma mark - Alerts

- (void)showAlertSheetWithMessage:(NSString *)message additionalInfo:(NSString *)additionalInfo buttonOneText:(NSString *)buttonOneText buttonTwoText:(NSString *)buttonTwoText attachedToWindow:(NSWindow *)window withSelector:(SEL)selector{
    NSBeginAlertSheet(
                      message,                      // sheet message
                      @"Ok",                        // default button label
                      nil,                          // no third button
                      nil,                          // other button label
                      window,                       // window sheet is attached to
                      self,                         // we’ll be our own delegate
                      NULL,                     // did-end selector
                      selector,                   // no need for did-dismiss selector
                      window,                 // context info
                      additionalInfo);
    
    
}

- (void)sheetDidEndShouldDelete: (NSWindow *)sheet
                     returnCode: (NSInteger)returnCode
                    contextInfo: (void *)contextInfo
{
    if (returnCode == NSAlertDefaultReturn){
        
        [self commitGist];
    }
    
}

// ------------------------------------------------------------------------------------------
#pragma mark - Notifications
// ------------------------------------------------------------------------------------------
- (void)fetchActiveIDEWorkspaceWindow:(NSNotification *)notification
{
    id window = [notification object];
    if ([window isKindOfClass:[NSWindow class]] && [window isMainWindow])
    {
        self.ideWorkspaceWindow = window;
    }
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


#pragma mark - Custom property accessors
-(BTGitHubEngine *)githubEngine{
    if (!_githubEngine){
        self.githubEngine = [[BTGitHubEngine alloc]initWithUsername:self.userCredential.username password:self.userCredential.password withReachability:YES];
    }
    return _githubEngine;
}



@end
