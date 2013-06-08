//
//  GisterPostWindowController.h
//  GisterPost
//
//  Created by Thomas Blitz on 07/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UserCredential.h"
#import "LoginProtocol.h"

@interface GisterPostWindowController : NSWindowController <NSUserNotificationCenterDelegate, LoginProtocol>

//@property (nonatomic, assign) id<LoginProtocol> delegate;

@property (nonatomic, copy) NSString *gistText;

@property (nonatomic, retain) UserCredential *userCredential;

@property (assign) IBOutlet NSView *commitView;

@property (assign) IBOutlet NSWindow *mainWindow;

@property (assign) IBOutlet NSButton *privateGistCheckBox;

@property (assign) IBOutlet NSTextField *gistDescriptionTextField;

@property (assign) IBOutlet NSTextField *fileNameTextField;


- (IBAction)CommitGist:(id)sender;

- (IBAction)CancelCommit:(id)sender;

//- (id)initWithDelegate:(id<LoginProtocol>)delegate;

- (void)showGistDialogWindowWithGistText:(NSString *)gistText;

- (id)init;
@end
