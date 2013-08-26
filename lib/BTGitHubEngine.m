//
//  BTGitHubEngine.m
//  BTGitHubEngine
//
//  Created by Thomas Blitz on 07/06/13.
//  Copyright (c) 2013 Thomas Blitz. All rights reserved.
//

#import "BTGitHubEngine.h"
#import "UAGithubURLConnection.h"
#import "UAGithubEngineConstants.h"
#import "UAGithubJSONParser.h"

#import "NSInvocation+Blocks.h"
#import "NSData+Base64.h"
#import "NSString+UAGithubEngineUtilities.h"

#define API_PROTOCOL @"https://"
#define API_DOMAIN @"api.github.com"



@interface BTGitHubEngine()
@property BOOL isMultiPageRequest;
@property (nonatomic, retain) NSURL *nextPageURL;
@property (nonatomic, retain) NSURL *lastPageURL;
@property (nonatomic, retain) NSMutableArray *multiPageArray;
@end


@implementation BTGitHubEngine
#pragma mark
#pragma mark Setup & Teardown
#pragma mark

- (id)initWithUsername:(NSString *)aUsername password:(NSString *)aPassword withReachability:(BOOL)withReach
{
    self = [super init];
	if (self)
	{
		self.username = aUsername;
		self.password = aPassword;
		if (withReach)
		{
			self.reachability = [[UAReachability alloc] init];
		}
        self.multiPageArray = [@[] mutableCopy];
	}
	
	
	return self;
    
}


#pragma mark
#pragma mark Reachability
#pragma mark

- (BOOL)isReachable
{
	return [self.reachability currentReachabilityStatus];
}


- (UAReachability *)reachability
{
	if (!_reachability)
	{
		_reachability = [[UAReachability alloc] init];
        [_reachability retain];
	}
	return _reachability;
}




#pragma mark
#pragma mark Gists
#pragma mark

- (void)gistsForUser:(NSString *)user success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"users/%@/gists", user] requestType:UAGithubGistsRequest responseType:UAGithubGistsResponse error:nil];} success:successBlock failure:failureBlock];
}


- (void)gistsWithSuccess:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:@"gists" requestType:UAGithubGistsRequest responseType:UAGithubGistsResponse error:nil];} success:successBlock failure:failureBlock];
    
}

- (void)publicGistsWithSuccess:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:@"gists/public" requestType:UAGithubGistsRequest responseType:UAGithubGistsResponse error:nil];} success:successBlock failure:failureBlock];
}


- (void)starredGistsWithSuccess:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:@"gists/starred" requestType:UAGithubGistsRequest responseType:UAGithubGistsResponse error:nil];} success:successBlock failure:failureBlock];
}


- (void)gist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@", gistId] requestType:UAGithubGistRequest responseType:UAGithubGistResponse error:nil];} success:successBlock failure:failureBlock];
}


- (void)createGist:(NSDictionary *)gistDictionary success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:@"gists" requestType:UAGithubGistCreateRequest responseType:UAGithubGistResponse withParameters:gistDictionary error:nil];} success:successBlock failure:failureBlock];
}


- (void)editGist:(NSString *)gistId withDictionary:(NSDictionary *)gistDictionary success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@", gistId] requestType:UAGithubGistUpdateRequest responseType:UAGithubGistResponse withParameters:gistDictionary error:nil];} success:successBlock failure:failureBlock];
}


- (void)starGist:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@/star", gistId] requestType:UAGithubGistStarRequest responseType:UAGithubNoContentResponse error:nil];} booleanSuccess:successBlock failure:failureBlock];
}


- (void)unstarGist:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@/star", gistId] requestType:UAGithubGistUnstarRequest responseType:UAGithubNoContentResponse error:nil];} booleanSuccess:successBlock failure:failureBlock];
}


- (void)gistIsStarred:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@/star", gistId] requestType:UAGithubGistStarStatusRequest responseType:UAGithubNoContentResponse error:nil];} booleanSuccess:successBlock failure:failureBlock];
}


- (void)forkGist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@/fork", gistId] requestType:UAGithubGistForkRequest responseType:UAGithubGistResponse error:nil];} success:successBlock failure:failureBlock];
}


- (void)deleteGist:(NSString *)gistId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@", gistId] requestType:UAGithubGistDeleteRequest responseType:UAGithubNoContentResponse error:nil];} booleanSuccess:successBlock failure:failureBlock];
}


#pragma mark Comments

- (void)commentsForGist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@/comments", gistId] requestType:UAGithubGistCommentsRequest responseType:UAGithubGistCommentsResponse error:nil];} success:successBlock failure:failureBlock];
}


- (void)gistComment:(NSInteger)commentId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/comments/%ld", commentId] requestType:UAGithubGistCommentRequest responseType:UAGithubGistCommentResponse error:nil];} success:successBlock failure:failureBlock];
}


- (void)addCommitComment:(NSDictionary *)commentDictionary forGist:(NSString *)gistId success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/%@/comments", gistId] requestType:UAGithubGistCommentCreateRequest responseType:UAGithubGistCommentResponse withParameters:commentDictionary error:nil];} success:successBlock failure:failureBlock];
}


- (void)editGistComment:(NSInteger)commentId withDictionary:(NSDictionary *)commentDictionary success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/comments/%ld", commentId] requestType:UAGithubGistCommentUpdateRequest responseType:UAGithubGistCommentResponse withParameters:commentDictionary error:nil];} success:successBlock failure:failureBlock];
}


- (void)deleteGistComment:(NSInteger)commentId success:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    [self invoke:^(id self){[self sendRequest:[NSString stringWithFormat:@"gists/comments/%ld", commentId] requestType:UAGithubGistCommentDeleteRequest responseType:UAGithubNoContentResponse error:nil];} booleanSuccess:successBlock failure:failureBlock];
}





#pragma mark
#pragma mark Request Management
#pragma mark






- (id)sendRequest:(NSString *)path requestType:(UAGithubRequestType)requestType responseType:(UAGithubResponseType)responseType withParameters:(id)params page:(NSInteger)page error:(NSError **)error
{
    
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@%@/%@", API_PROTOCOL, API_DOMAIN, path];
    NSData *jsonData = nil;
    NSError *serializationError = nil;
    
    if ([params count] > 0)
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&serializationError];
        
        if (serializationError)
        {
            *error = serializationError;
            return nil;
        }
    }
    
    
    NSMutableString *querystring = nil;
    
    if (!jsonData && [params count] > 0)
	{
        // Is the querystring already present (ie a question mark is present in the path)? Create it if not.
        if ([path rangeOfString:@"?"].location == NSNotFound)
        {
            querystring = [NSMutableString stringWithString:@"?"];
        }
        
		for (NSString *key in [params allKeys])
		{
			[querystring appendFormat:@"%@%@=%@", [querystring length] <= 1 ? @"" : @"&", key, [[params valueForKey:key] encodedString]];
		}
	}
    
    if (page > 0)
    {
        if (querystring)
        {
            [querystring appendFormat:@"&page=%ld", page];
        }
        else
        {
            querystring = [NSString stringWithFormat:@"?page=%ld", page];
        }
    }
    
    if ([querystring length] > 0)
	{
		[urlString appendString:querystring];
	}
    
	NSURL *theURL = [NSURL URLWithString:urlString];
	
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
	if (self.username && self.password)
	{
		[urlRequest setValue:[NSString stringWithFormat:@"Basic %@", [[[NSString stringWithFormat:@"%@:%@", self.username, self.password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString]] forHTTPHeaderField:@"Authorization"];
	}
    
	if (jsonData)
    {
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:jsonData];
    }
    
	switch (requestType)
    {
        case UAGithubIssueAddRequest:
		case UAGithubRepositoryCreateRequest:
		case UAGithubRepositoryDeleteConfirmationRequest:
        case UAGithubMilestoneCreateRequest:
		case UAGithubDeployKeyAddRequest:
		case UAGithubDeployKeyDeleteRequest:
		case UAGithubIssueCommentAddRequest:
        case UAGithubPublicKeyAddRequest:
        case UAGithubRepositoryLabelAddRequest:
        case UAGithubIssueLabelAddRequest:
        case UAGithubTreeCreateRequest:
        case UAGithubBlobCreateRequest:
        case UAGithubReferenceCreateRequest:
        case UAGithubRawCommitCreateRequest:
        case UAGithubGistCreateRequest:
        case UAGithubGistCommentCreateRequest:
        case UAGithubGistForkRequest:
        case UAGithubPullRequestCreateRequest:
        case UAGithubPullRequestCommentCreateRequest:
        case UAGithubEmailAddRequest:
        case UAGithubTeamCreateRequest:
        case UAGithubMarkdownRequest:
        case UAGithubRepositoryMergeRequest:
		{
			[urlRequest setHTTPMethod:@"POST"];
		}
			break;
            
		case UAGithubCollaboratorAddRequest:
        case UAGithubIssueLabelReplaceRequest:
        case UAGithubFollowRequest:
        case UAGithubGistStarRequest:
        case UAGithubPullRequestMergeRequest:
        case UAGithubOrganizationMembershipPublicizeRequest:
        case UAGithubTeamMemberAddRequest:
        case UAGithubTeamRepositoryManagershipAddRequest:
        case UAGithubNotificationsMarkReadRequest:
        case UAGithubNotificationThreadSubscriptionRequest:
        {
            [urlRequest setHTTPMethod:@"PUT"];
        }
            break;
            
		case UAGithubRepositoryUpdateRequest:
        case UAGithubMilestoneUpdateRequest:
        case UAGithubIssueEditRequest:
        case UAGithubIssueCommentEditRequest:
        case UAGithubPublicKeyEditRequest:
        case UAGithubUserEditRequest:
        case UAGithubRepositoryLabelEditRequest:
        case UAGithubReferenceUpdateRequest:
        case UAGithubGistUpdateRequest:
        case UAGithubGistCommentUpdateRequest:
        case UAGithubPullRequestUpdateRequest:
        case UAGithubPullRequestCommentUpdateRequest:
        case UAGithubOrganizationUpdateRequest:
        case UAGithubTeamUpdateRequest:
        case UAGithubNotificationsMarkThreadReadRequest:
        {
            [urlRequest setHTTPMethod:@"PATCH"];
        }
            break;
            
        case UAGithubMilestoneDeleteRequest:
        case UAGithubIssueDeleteRequest:
        case UAGithubIssueCommentDeleteRequest:
        case UAGithubUnfollowRequest:
        case UAGithubPublicKeyDeleteRequest:
		case UAGithubCollaboratorRemoveRequest:
        case UAGithubRepositoryLabelRemoveRequest:
        case UAGithubIssueLabelRemoveRequest:
        case UAGithubGistUnstarRequest:
        case UAGithubGistDeleteRequest:
        case UAGithubGistCommentDeleteRequest:
        case UAGithubPullRequestCommentDeleteRequest:
        case UAGithubEmailDeleteRequest:
        case UAGithubOrganizationMemberRemoveRequest:
        case UAGithubOrganizationMembershipConcealRequest:
        case UAGithubTeamDeleteRequest:
        case UAGithubTeamMemberRemoveRequest:
        case UAGithubTeamRepositoryManagershipRemoveRequest:
        case UAGithubNotificationDeleteSubscriptionRequest:
        {
            [urlRequest setHTTPMethod:@"DELETE"];
        }
            break;
            
		default:
			break;
	}
	
    NSError __block *blockError = nil;
    NSError *connectionError = nil;
    
    id returnValue = [UAGithubURLConnection asyncRequest:urlRequest
                                                 success:^(NSData *data, NSURLResponse *response)
                      {
                          NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
                          NSInteger statusCode = resp.statusCode;
                          
                          
                          if ([[[resp allHeaderFields] allKeys] containsObject:@"X-Ratelimit-Remaining"] && [[[resp allHeaderFields] valueForKey:@"X-Ratelimit-Remaining"] isEqualToString:@"1"])
                          {
                              blockError = [NSError errorWithDomain:UAGithubAPILimitReached code:statusCode userInfo:[NSDictionary dictionaryWithObject:urlRequest forKey:@"request"]];
                              return (id)[NSNull null];
                          }
                          
                          if (statusCode >= 400)
                          {
                              if (statusCode == 404)
                              {
                                  switch (requestType)
                                  {
                                      case UAGithubFollowingRequest:
                                      case UAGithubGistStarStatusRequest:
                                      case UAGithubOrganizationMembershipStatusRequest:
                                      case UAGithubTeamMembershipStatusRequest:
                                      case UAGithubTeamRepositoryManagershipStatusRequest:
                                      {
                                          return (id)[NSNumber numberWithBool:NO];
                                      }
                                          break;
                                      default:
                                          break;
                                  }
                              }
                              
                              blockError = [NSError errorWithDomain:@"HTTP" code:statusCode userInfo:[NSDictionary dictionaryWithObject:urlRequest forKey:@"request"]];
                              
                              return (id)[NSNull null];
                              
                          }
                          
                          else if (statusCode == 204)
                          {
                              return (id)[NSNumber numberWithBool:YES];
                          }
                          else if (requestType == UAGithubMarkdownRequest)
                          {
                              return (id)[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                          }
                          
                          else
                          {
                              if ([[[resp allHeaderFields] allKeys] containsObject:@"Link"])
                              {
                                  self.isMultiPageRequest = YES;
                                  NSString *linkHeader = [[resp allHeaderFields] valueForKey:@"Link"];
                                  NSArray *links = [linkHeader componentsSeparatedByString:@","];
                                  self.nextPageURL = nil;
                                  NSURL * __block blockURL = nil;
                                  [links enumerateObjectsUsingBlock:^(NSString *link, NSUInteger idx, BOOL *stop) {
                                      NSString *rel = [[link componentsSeparatedByString:@";"][1] componentsSeparatedByString:@"\""][1];
                                      if ([rel isEqualToString:@"next"])
                                      {
                                          blockURL = [NSURL URLWithString:[[link componentsSeparatedByString:@";"][0] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]];
                                          *stop = YES;
                                      }
                                  }];
                                  self.nextPageURL = blockURL;
                              }
                              return [UAGithubJSONParser parseJSON:data error:&blockError];
                          }
                          
                      }
                                                   error:&connectionError];
    
    if (blockError)
    {
        *error = blockError;
        return nil;
    }
    else if (connectionError)
    {
        *error = connectionError;
        return nil;
    }
    
    // If returnValue is of class NSArray, it contains an array of NSDictionary objects.
    // If it's an NSNumber YES, then we're looking at a successful call that expects a No Content response.
    // If it's an NSNumber NO then that's a successful call to a method that returns an expected 404 response.
    
    return returnValue;
}


- (id)sendRequest:(NSString *)path requestType:(UAGithubRequestType)requestType responseType:(UAGithubResponseType)responseType withParameters:(id)params error:(NSError **)error
{
    return [self sendRequest:path requestType:requestType responseType:responseType withParameters:params page:0 error:error];
}


- (id)sendRequest:(NSString *)path requestType:(UAGithubRequestType)requestType responseType:(UAGithubResponseType)responseType page:(NSInteger)page error:(NSError **)error
{
    return [self sendRequest:path requestType:requestType responseType:responseType withParameters:nil page:page error:error];
}


- (id)sendRequest:(NSString *)path requestType:(UAGithubRequestType)requestType responseType:(UAGithubResponseType)responseType error:(NSError **)error
{
    return [self sendRequest:path requestType:requestType responseType:responseType withParameters:nil page:0 error:error];
}


- (void)invoke:(void (^)(id obj))invocationBlock success:(UAGithubEngineSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    NSError *error = nil;
    NSError **errorPointer = &error;
    id result;// result = nil;
    
    NSInvocation *invocation = [NSInvocation jr_invocationWithTarget:self block:invocationBlock];
    // Method signatures differ between invocations, but the last argument is always where the NSError lives
    [invocation setArgument:&errorPointer atIndex:[[invocation methodSignature] numberOfArguments] - 1];
    [invocation invoke];
    [invocation getReturnValue:&result];
    
    
    if (error)
    {
        failureBlock(error);
        return;
    }
    
    while (self.isMultiPageRequest && self.nextPageURL)
    {
        [self.multiPageArray addObjectsFromArray:result];
        NSMutableString *requestPath = [self.nextPageURL query] ? [[[self.nextPageURL path] stringByAppendingFormat:@"?%@", [self.nextPageURL query]] mutableCopy] : [[self.nextPageURL path] mutableCopy];
        [requestPath deleteCharactersInRange:NSMakeRange(0, 1)];
        
        [invocation setArgument:&requestPath atIndex:2];
        [invocation setArgument:&errorPointer atIndex:[[invocation methodSignature] numberOfArguments] - 1];
        [invocation invoke];
        [invocation getReturnValue:&result];
    }
    
    if (self.isMultiPageRequest)
    {
        [self.multiPageArray addObjectsFromArray:result];
        NSLog(@"%@", @([self.multiPageArray count]));
        successBlock(self.multiPageArray);
    }
    else
    {
        successBlock(result);
    }
}


- (void)invoke:(void (^)(id obj))invocationBlock booleanSuccess:(UAGithubEngineBooleanSuccessBlock)successBlock failure:(UAGithubEngineFailureBlock)failureBlock
{
    
    NSError __unsafe_unretained *error = nil;
    NSError * __unsafe_unretained *errorPointer = &error;
    BOOL result;
    
    NSInvocation *invocation = [NSInvocation jr_invocationWithTarget:self block:invocationBlock];
    [invocation setArgument:&errorPointer atIndex:[[invocation methodSignature] numberOfArguments] - 1];
    [invocation invoke];
    [invocation getReturnValue:&result];
    
    if (error)
    {
        failureBlock(error);
        return;
    }
    
    successBlock(result);
}



- (void)dealloc{
    self.username = nil;
    [self.username dealloc];
    
    self.password = nil;
    [self.password dealloc];
    
    self.nextPageURL = nil;
    [self.nextPageURL dealloc];
    
    self.lastPageURL = nil;
    [self.lastPageURL dealloc];
    
    self.multiPageArray = nil;
    [self.multiPageArray dealloc];
    
    self.reachability = nil;
    [self.reachability dealloc];
    
    [super dealloc];
}
@end
