//
//  PlaylistItem.m
//  iOSCodingAssignment
//
//  Created by Hari Krishna Palempati on 11/11/15.
//  Copyright © 2015 ios.hari. All rights reserved.
//

#import "PlayListEntry.h"

@implementation PlayListEntry

#pragma mark - Object Life cycle

- (instancetype)initWithValuesDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _title = dictionary[@"title"];
    _subtitle = dictionary[@"description"];
    _imageURL = dictionary[@"thumbnails"][@"default"][@"url"];
    return self;
}

@end
