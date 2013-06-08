//
//  BTGitHubEngine.h
//  BTGitHubEngine
//
//  Created by Thomas Blitz on 07/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAGithubEngineRequestTypes.h"
#import "UAReachability.h"


typedef void (^UAGithubEngineSuccessBlock)(id);
typedef void (^UAGithubEngineBooleanSuccessBlock)(BOOL);
typedef void (^UAGithubEngineFailureBlock)(NSError *);

@interface BTGitHubEngine : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, retain) UAReachability *reachability;
@property (nonatomic, assign, readonly) BOOL isReachable;

- (id)initWithUsername:(NSString *)aUsername password:(NSString *)aPassword withReachability:(BOOL)withReach;

#pragma mark
#pragma mark Gists
#pragma mark

- (void)gistsForUser:(NSString *)user success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)gistsWithSuccess:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)publicGistsWithSuccess:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)starredGistsWithSuccess:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)gist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)createGist:(NSDictionary *)gistDictionary success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)editGist:(NSString *)gistId withDictionary:(NSDictionary *)gistDictionary success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)starGist:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)unstarGist:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)gistIsStarred:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)forkGist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)deleteGist:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;


#pragma mark Comments

- (void)commentsForGist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)gistComment:(NSInteger)commentId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)addCommitComment:(NSDictionary *)commentDictionary forGist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)editGistComment:(NSInteger)commentId withDictionary:(NSDictionary *)commentDictionary success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;
- (void)deleteGistComment:(NSInteger)commentId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock;








@end
