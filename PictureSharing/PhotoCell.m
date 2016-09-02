//
//  PhotoCell.m
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/5/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import "PhotoCell.h"
#import <SAMCache/SAMCache.h>
#import "PhotoController.h"

@implementation PhotoCell


- (void) setPhoto:(NSDictionary *)photo {
    _photo = photo;

    NSArray * pics = _photo[@"photos"];
    NSLog(@"again: %@", pics[0][@"original_size"][@"url"]);

    if (pics[0][@"original_size"][@"url"]) {
    
    [PhotoController imageForPhoto:_photo size:@"original_size" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    NSLog(@"YOOOO");
   // NSString *caption = [[NSString alloc] initWithString:_photo[@"response"][@"posts"][@"photos"][@"caption"]];
   // NSLog(@"caption: %@", caption);
    
//    NSURL *url = [[NSURL alloc] initWithString:pics[0][@"original_size"][@"url"]];
//    NSLog(@"photoURLLL: %@", url);
//            [self downloadPhotoWithURL:url];
    
    NSLog(@"YOOOO2");
    }
}

- (id)initWithFrame:(CGRect)frame {
    /**
     self = [super initWithFrame:frame];
     if (self) {
     self.imageView = [[UIImageView alloc] init];
     UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
     tap.numberOfTapsRequired = 2;
     [self addGestureRecognizer:tap];
     
     [self.contentView addSubview:self.imageView];
     }
     return self;
     **/
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        longPress.minimumPressDuration = 1.0f;
        
        [self addGestureRecognizer:longPress];
        
        //        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(like)];
        //        tap.numberOfTapsRequired = 2;
        //        [self addGestureRecognizer:tap];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}
/**
 - (void) downloadPhotoWithURL:(NSURL *)url {
 //    NSString *key = [[NSString alloc] initWithFormat:@"%@-thumbnail", self.photo[@"id"]];
 //    UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
 //    if (photo) {
 //        self.imageView.image = photo;
 //        return;
 //    }
     
 NSURLSession *session = [NSURLSession sharedSession];
 NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
 NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
     NSData *data = [[NSData alloc] initWithContentsOfURL:location];
     UIImage *image = [[UIImage alloc] initWithData:data];
     //[[SAMCache sharedCache] setImage:image forKey:key];
 
     dispatch_async(dispatch_get_main_queue(), ^{
     self.imageView.image = image;
     });
    }];
 [task resume];
 }

**/
- (void) like {
    
    //NSLog(@"Link: %@", self.photo[@"link"]);
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *blogID = [[NSUserDefaults standardUserDefaults] objectForKey:@"blogID"];
   // NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    //NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], accessToken];
    
    //api.tumblr.com/v2/blog/{blog-identifier}/post/edit
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.tumblr.com/v2/tagged?tag=beach&api_key=%@", @"YsYwy8V8FvlBGbHFV9OFWokio8MsO6AygeCOecN5ywyxTk0AM6"];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response: %@", response);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLikeCompletion];
        });
    }];
    [task resume];
    
}

- (void) showLikeCompletion {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Liked!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}

@end
