//
//  MyPlaylistTableViewCell.h
//  iOSCodingAssignment
//
//  Created by Hari Krishna Palempati on 11/11/15.
//  Copyright © 2015 ios.hari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayListEntry.h"

@interface PlaylistTableViewCell : UITableViewCell

/**
 *  @brief The thumbimage.
 */
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;

/**
 *  @brief The title label.
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  @brief The subtitle label.
 */
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

/**
 *  @brief Use this method to configure cell with playlist entry.
 *
 *  @param item PlaylistEntry
 */
- (void)configureCellWithPlayListEntry:(PlayListEntry *)item;

@end
