//
//  MyPlaylistDataRequestor.h
//  iOSCodingAssignment
//
//  Created by Hari Krishna Palempati on 11/11/15.
//  Copyright © 2015 ios.hari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPlaylistDataRequestor : NSObject

/**
 *  @brief Use this method to get JSON from URL String
 *
 *  @param urlString the URL String
 *  @param success   success block
 *  @param failure   failure block
 */
- (void)getJSONFromURLString:(NSString *)urlString success:(void (^)(NSArray *))success
                        failure:(void (^)(NSError *))failure;


@end
