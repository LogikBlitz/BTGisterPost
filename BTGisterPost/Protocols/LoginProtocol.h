//
//  LoginProtocol.h
//  GisterPost
//
//  Created by Thomas Blitz on 06/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UserCredential.h"

@protocol LoginProtocol <NSObject>

@required

- (void)userCancelledLogin;

- (void)credentialCreated:(UserCredential *)credential;

@end
