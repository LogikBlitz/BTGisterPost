//
//  UserCredential.h
//  GisterPost
//
//  Created by Thomas Blitz on 06/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCredential : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

- (id)initWithUsernam:(NSString *)username andPassword:(NSString *)password;
@end
