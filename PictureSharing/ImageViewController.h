//
//  ImageViewController.h
//  CLImageEditorDemo
//
//  Created by sho yakushiji on 2013/11/14.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarDelegate, UIActionSheetDelegate, UIScrollViewDelegate>
{
    //__weak IBOutlet UIScrollView *_scrollView;
    //__weak IBOutlet UIImageView *_imageView;
    //IBOutlet __weak UIScrollView *_scrollView;
    //IBOutlet __weak UIImageView *_imageView;
    //__weak IBOutlet UITabBar *tabMenu;
    IBOutlet UIView *mainView;
    //IBOutlet UIView *imageCont;
    //__weak IBOutlet UITabBar *tabBar;
    
    UIScrollView * _scrollView;
    UIImageView * _imageView;
}

//@property (strong, nonatomic) UIWindow *window;
- (id)initWithImage:(UIImage*)image;
@end
