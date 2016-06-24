//
//  PlaylistItem.h
//  iOSCodingAssignment
//
//  Created by Hari Krishna Palempati on 11/11/15.
//  Copyright © 2015 ios.hari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayListEntry : NSObject

/**
 *  @brief  The playlist entry title.
 */
@property (nonatomic, strong) NSString *title;

/**
 *  @brief  The playlist entry subtitle.
 */
@property (nonatomic, strong) NSString *subtitle;

/**
 *  @brief  The image url.
 */
@property (nonatomic, strong) NSString *imageURL;

/**
 *  @brief  The playlist entry thumbnail.
 */
@property (nonatomic, strong) UIImage *thumbnail;

/**
 *  @brief Use this method to instantiate PlaylistEntry with given dictionary
 *
 *  @param dictionay The playlist item values dictionary
 *
 *  @return the PlaylistItem
 */
- (instancetype)initWithValuesDictionary:(NSDictionary *)dictionary;

@end
