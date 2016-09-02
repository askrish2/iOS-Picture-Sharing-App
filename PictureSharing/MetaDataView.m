//
//  MetaDataView.m
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/6/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import "MetaDataView.h"
#import "DismissDetailTransition.h"
#import "PhotoController.h"
#import "DetailViewController.h"
#import "PresentDetailTransition.h"
#import <SAMCategories/NSDate+SAMAdditions.h>
#import "CLImageEditor.h"

@interface MetaDataView () <UIViewControllerTransitioningDelegate>
@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIButton *usernameButton;
@property (nonatomic) UIButton *timeButton;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIButton *commentsButton;
@property (nonatomic) UIBarButtonItem *shareButton;
@end

@implementation MetaDataView

- (void)setPhoto:(NSDictionary *)photo {
    _photo = photo;
    
    NSDate *createdAt = [NSDate dateWithTimeIntervalSince1970:[_photo[@"timestamp"] doubleValue]];
    [self.timeButton setTitle:[createdAt sam_briefTimeInWords] forState:UIControlStateNormal];
    
    //Set the username
    /**
     
     [self.usernameButton setTitle:_photo[@"username"] forState:UIControlStateNormal];
     
     //Set the number of likes
     
     [self.likesButton setTitle:_photo[@"likes"][@"count"] forState:UIControlStateNormal];
     
     //Set the number of comments
     
     [self.commentsButton setTitle:_photo[@"comments"][@"count"] forState:UIControlStateNormal];
     **/
    
    // TODO: Set the avatar, username, time, number of likes, and number of comments
    
    
    NSNumber *likes = self.photo[@"note_count"];
    //CGFloat  myFloat = [(NSNumber*) likes floatValue];
    NSInteger intLikes = [likes integerValue];
    [self.likesButton setTitle:[NSString stringWithFormat:@"%li", intLikes] forState:UIControlStateNormal];
    
    /**
    NSNumber *comments = self.photo[@"reblog"];
    NSInteger intComments = [comments integerValue];
    [self.commentsButton setTitle:[NSString stringWithFormat:@"%li", intComments] forState:UIControlStateNormal];
    **/
    
    [self.commentsButton setTitle:@"Reblog" forState:UIControlStateNormal];
     
    NSString *username = _photo[@"blog_name"];
    NSLog(@"user: %@", username);
    [self.usernameButton setTitle:username forState:UIControlStateNormal];
    
     
    //[self.shareButton setTitle:@"Share"];
    
    // NSURL *url = _photo[@"user"][@"profile_picture"];
    // NSData *data = [NSData dataWithContentsOfURL : url];
    // UIImage *image = [UIImage imageWithData: data];
    
    //[self.avatarImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_photo[@"user"][@"profile_picture"]]]]];
}


#pragma mark - Actions

- (void)openUser:(id)sender {
    // open link in safari to user profile
    NSString *username = _photo[@"blog_name"];
    NSString *urlUserString = [[NSString alloc] initWithFormat:@"http://www.%@.tumblr.com", username];
    NSURL *userUrl = [[NSURL alloc] initWithString:urlUserString];
    [[UIApplication sharedApplication] openURL:userUrl];
    
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentDetailTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[DismissDetailTransition alloc] init];
}



- (void)openPhoto:(id)sender {
    // open link in safari to the photo page
   
    NSString *stringPhoto = _photo[@"photos"][0][@"original_size"][@"url"];
    NSString *urlPhotoString = [[NSString alloc] initWithFormat:@"%@", stringPhoto];
    NSURL *PhotoUrl = [[NSURL alloc] initWithString:urlPhotoString];
    [[UIApplication sharedApplication] openURL:PhotoUrl];
    


}




- (void) openReblog:(id)sender {
    // open link to reblog photo
    NSString *username = _photo[@"blog_name"];
    NSString *photoID = _photo[@"id"];
    NSString *reblogID = _photo[@"reblog_key"];
    //https://www.tumblr.com/reblog/148553418698/inzVoy9B
    NSString *urlUserString = [[NSString alloc] initWithFormat:@"http://www.tumblr.com/reblog/%@/%@", photoID, reblogID];
    NSURL *userUrl = [[NSURL alloc] initWithString:urlUserString];
    [[UIApplication sharedApplication] openURL:userUrl];
    
}
/**
- (void) openLikes:(id)sender {
    NSNumber *mediaId = _photo[@"id"];
    NSInteger intId = [mediaId integerValue];
    NSLog(@"id: %li:", intId);
    //NSString *username = _photo[@"user"][@"username"];
    //NSString *accessToken = responseObject[@"credentials"][@"token"];
    NSString *accessToken = @"1796979163.5aba63e.74957a7daa644a59a5042b08161739ee";
    NSString *urlUserString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%li/likes?access_token=%@", intId, accessToken];
    NSURL *userUrl = [[NSURL alloc] initWithString:urlUserString];
    [[UIApplication sharedApplication] openURL:userUrl];
}
 **/
#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.usernameButton];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.timeButton];
        [self addSubview:self.likesButton];
        [self addSubview:self.commentsButton];
    }
    return self;
}


- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(320.0f, 400.0f);
}


#pragma mark - UIControls

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 32.0f, 32.0f)];
        _avatarImageView.layer.cornerRadius = 16.0f;
        _avatarImageView.layer.borderColor = [[self class] darkTextColor].CGColor;
        _avatarImageView.layer.borderWidth = 1.0f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
        _avatarImageView.userInteractionEnabled = NO;
    }
    return _avatarImageView;
}


- (UIButton *)usernameButton {
    if (!_usernameButton) {
        _usernameButton = [[UIButton alloc] initWithFrame:CGRectMake(47.0f, 0.0f, 200.0f, 32.0f)];
        _usernameButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _usernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIColor *textColor = [[self class] darkTextColor];
        [_usernameButton setTitleColor:textColor forState:UIControlStateNormal];
        [_usernameButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_usernameButton addTarget:self action:@selector(openUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _usernameButton;
}


- (UIButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 0.0f, 50.0f, 32.0f)];
        _timeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_timeButton setImage:[UIImage imageNamed:@"time"] forState:UIControlStateNormal];
        _timeButton.adjustsImageWhenHighlighted = NO;
        _timeButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        UIColor *textColor = [[self class] lightTextColor];
        [_timeButton setTitleColor:textColor forState:UIControlStateNormal];
        [_timeButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_timeButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}


- (UIButton *)likesButton {
    if (!_likesButton) {
        _likesButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 360.0f, 50.0f, 40.0f)];
        _likesButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_likesButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        _likesButton.adjustsImageWhenHighlighted = NO;
        _likesButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        
        UIColor *textColor = [[self class] lightTextColor];
        [_likesButton setTitleColor:textColor forState:UIControlStateNormal];
        [_likesButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_likesButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likesButton;
}


- (UIButton *)commentsButton {
    if (!_commentsButton) {
        _commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 360.0f, 50.0f, 40.0f)];
        _commentsButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [_commentsButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        _commentsButton.adjustsImageWhenHighlighted = NO;
        _commentsButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _commentsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        UIColor *textColor = [[self class] lightTextColor];
        [_commentsButton setTitleColor:textColor forState:UIControlStateNormal];
        [_commentsButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_commentsButton addTarget:self action:@selector(openReblog:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentsButton;
}

/**
 - (UIBarButtonItem *)shareButton:(UIBarButtonItem *)sender {
 _shareButton = [[UIBarButtonItem alloc]
 initWithBarButtonSystemItem:UIBarButtonSystemItemAction
 target:self
 action:@selector(shareAction:)];
 //self.navigationItem.rightBarButtonItem = _shareButton;
 
 
 return _shareButton;
 }
 **/
//{
//    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
//    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
//
//    NSArray *objectsToShare = @[textToShare, myWebsite];
//
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
//
//    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
//                                   UIActivityTypePrint,
//                                   UIActivityTypeAssignToContact,
//                                   UIActivityTypeSaveToCameraRoll,
//                                   UIActivityTypeAddToReadingList,
//                                   UIActivityTypePostToFlickr,
//                                   UIActivityTypePostToVimeo];
//
//    activityVC.excludedActivityTypes = excludeActivities;
//[self PresentDetailTransition:activityVC animated:YES completion:nil];


#pragma mark - Private

+ (UIColor *)darkTextColor {
    return [UIColor colorWithRed:0.949f green:0.510f blue:0.380f alpha:1.0f];
}


+ (UIColor *)lightTextColor {
    return [UIColor colorWithRed:0.973f green:0.753f blue:0.686f alpha:1.0f];
}


@end
