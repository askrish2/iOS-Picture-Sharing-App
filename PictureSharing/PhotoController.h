//
//  PhotoController.h
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/6/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;


@end
