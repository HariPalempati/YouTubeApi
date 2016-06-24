//
//  MyPlaylistTableViewCell.m
//  iOSCodingAssignment
//
//  Created by Hari Krishna Palempati on 11/11/15.
//  Copyright © 2015 ios.hari. All rights reserved.
//

#import "PlaylistTableViewCell.h"

@implementation PlaylistTableViewCell

#pragma mark - Private Instance Method

- (void)configureCellWithPlayListEntry:(PlayListEntry *)item {
    
    __weak typeof (self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:item.imageURL]];
        if (imgData.length > 0) {
            UIImage *image = [UIImage imageWithData:imgData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    strongSelf.titleLabel.text = item.title;
                    strongSelf.subtitleLabel.text = item.subtitle;
                    strongSelf.thumbImage.image = image;
                });
            }
        }
    });
}

@end
