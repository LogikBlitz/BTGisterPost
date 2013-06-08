//
//  UserCredential.m
//  GisterPost
//
//  Created by Thomas Blitz on 06/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import "UserCredential.h"

@implementation UserCredential
- (id)initWithUsernam:(NSString *)username andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

@end
