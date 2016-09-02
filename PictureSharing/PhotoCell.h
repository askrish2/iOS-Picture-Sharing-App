//
//  PhotoCell.h
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/5/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell
@property (nonatomic) UIImageView* imageView;
@property (nonatomic) NSDictionary* photo;
@end
