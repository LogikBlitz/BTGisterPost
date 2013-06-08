//
//  LoginWindowController.h
//  BTGisterPost
//
//  Created by Thomas Blitz on 08/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "LoginProtocol.h"

@interface LoginWindowController : NSWindowController

@property (assign) IBOutlet NSWindow *loginWindow;

@property (assign) IBOutlet NSTextField *usernameTextField;

@property (assign) IBOutlet NSTextField *passwordTextField;

@property (nonatomic, assign) id<LoginProtocol> delegate;

- (IBAction)loginButtonPushed:(id)sender;
- (IBAction)cancelButtonPushed:(id)sender;

- (void)showModalLoginViewInWindow:(NSWindow *)window;

- (void)closeModelWindow: (id)sender;

- (id)initWithDelegate:(id<LoginProtocol>)delegate;
@end
