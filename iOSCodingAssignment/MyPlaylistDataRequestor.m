//
//  MyPlaylistDataRequestor.m
//  iOSCodingAssignment
//
//  Created by Hari Krishna Palempati on 11/11/15.
//  Copyright © 2015 ios.hari. All rights reserved.
//

#import "MyPlaylistDataRequestor.h"
#import "PlayListEntry.h"

@interface MyPlaylistDataRequestor ()
@property (nonatomic, copy) void (^successBlock)(NSArray *);
@end

@implementation MyPlaylistDataRequestor

#pragma mark - Private Instance Methods

- (void)getJSONFromURLString:(NSString *)urlString success:(void (^)(NSArray *))success
                     failure:(void (^)(NSError *))failure {
    
    self.successBlock = success;
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
/*
 
 // For timeout and cellular access
 
        config.timeoutIntervalForRequest = 60;
        config.allowsCellularAccess = YES;
 */
    
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    request.HTTPMethod = @"GET";
    
    
    __weak typeof (self) weakSelf = self;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                
                                                __strong typeof(weakSelf) strongSelf = weakSelf;
                                                
                                                if (!error) {
                                                    NSError *error;
                                                    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                               options:NSJSONReadingAllowFragments error:&error];
                                                    
                                                    
                                                    NSArray *items = responseDictionary[@"items"];
                                                    [strongSelf buildPlayListEntriesFromArray:items];
                                                }
                                                else {
                                                    failure(error);
                                                }
                                            }];
    [task resume];
}

- (void)buildPlayListEntriesFromArray:(NSArray *)rawItems {
    
    __block NSMutableArray *playListItems = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [rawItems enumerateObjectsUsingBlock:^(NSDictionary *rawDictionary, NSUInteger idx, BOOL *stop){
            
            PlayListEntry *item = [[PlayListEntry alloc] initWithValuesDictionary:rawDictionary[@"snippet"]];
            [playListItems addObject:item];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successBlock(playListItems);
        });
    });
}




@end
