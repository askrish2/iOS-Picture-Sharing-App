//
//  PhotoController.m
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/6/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import "PhotoController.h"
#import <UIKit/UIKit.h>
#import <SAMCache/SAMCache.h>

@implementation PhotoController
/**
 + (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion {
 
 if (photo == nil || size == nil || completion == nil) {
 return;
 }
 
 NSString *key = [[NSString alloc] initWithFormat:@"%@-%@", photo[@"id"], size];
 UIImage *image = [[SAMCache sharedCache] imageForKey:key];
 if (image) {
 completion(image);
 return;
 }
 
 NSURL *url = [[NSURL alloc] initWithString:photo[@"images"][size][@"url"]];
 NSURLSession *session = [NSURLSession sharedSession];
 NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
 NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
 NSData *data = [[NSData alloc] initWithContentsOfURL:location];
 UIImage *image = [[UIImage alloc] initWithData:data];
 [[SAMCache sharedCache] setImage:image forKey:key];
 
 dispatch_async(dispatch_get_main_queue(), ^{
 completion(image);
 });
 }];
 [task resume];
 }
 **/

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion {
    if (photo == nil || size == nil || completion == nil) {
        return;
    }
    
    NSString *key = [[NSString alloc] initWithFormat:@"%@-%@", photo[@"id"], size];
    NSURL *url = [[NSURL alloc] initWithString:photo[@"photos"][0][size][@"url"]];
    [self downloadURL:url key:key completion:completion];
}

/**
+ (void)avatarForPhoto:(NSDictionary *)photo completion:(void(^)(UIImage *image))completion {
    if (photo == nil || completion == nil) {
        return;
    }
    
    NSString *key = [[NSString alloc] initWithFormat:@"avatar-%@", photo[@"user"][@"id"]];
    NSURL *url = [[NSURL alloc] initWithString:photo[@"user"][@"profile_picture"]];
    [self downloadURL:url key:key completion:completion];
}
**/

#pragma mark - Private

+ (void)downloadURL:(NSURL *)url key:(NSString *)key completion:(void(^)(UIImage *image))completion {
    UIImage *image = [[SAMCache sharedCache] imageForKey:key];
    if (image) {
        completion(image);
        return;
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        [[SAMCache sharedCache] setImage:image forKey:key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
    }];
    [task resume];
}

@end
