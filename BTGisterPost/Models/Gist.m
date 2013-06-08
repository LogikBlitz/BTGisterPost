//
//  Gist.m
//  BTGisterPost
//
//  Created by Thomas Blitz on 08/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import "Gist.h"

@implementation Gist
- (id)initWithGistText:(NSString *)gistText andFilename:(NSString *)filename andDescription:(NSString *)description isPrivate:(BOOL)isPublic
{
    self = [super init];
    if (self) {
        self.gistText = gistText;
        self.filename = filename;
        self.description = description;
        self.isPublic = isPublic;
    }
    return self;
}


- (NSDictionary *)gistAsDictionary{
    NSDictionary *contentDict = @{@"content": self.gistText};
    NSDictionary *filenameDict = @{self.filename: contentDict};
    NSNumber *isPublicNumber = [NSNumber numberWithBool:self.isPublic];
    
    NSLog(@"Is publicNumber is: %@", isPublicNumber);
    NSDictionary *gistDict = @{@"description": self.description,
                               @"public": isPublicNumber,
                               @"files":filenameDict
                               };
    return gistDict;

}
@end
