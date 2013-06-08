//
//  Gist.h
//  BTGisterPost
//
//  Created by Thomas Blitz on 08/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gist : NSObject

@property (nonatomic, retain) NSString *gistText;
@property (nonatomic, retain) NSString *filename;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) BOOL isPublic;

- (id)initWithGistText:(NSString *)gistText andFilename:(NSString *)filename andDescription:(NSString *)description isPrivate:(BOOL)isPublic;

- (NSDictionary *)gistAsDictionary;


@end
