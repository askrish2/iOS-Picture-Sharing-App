//
//  CLImageEditor.m
//
//  Created by sho yakushiji on 2013/10/17.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import "CLImageEditor.h"

#import "_CLImageEditorViewController.h"

@interface CLImageEditor ()

@end


@implementation CLImageEditor

- (id)init
{
    NSLog(@"1");

    return [_CLImageEditorViewController new];
}

- (id)initWithImage:(UIImage*)image
{
    NSLog(@"1");
    return [self initWithImage:image delegate:nil];
}

- (id)initWithImage:(UIImage*)image delegate:(id<CLImageEditorDelegate>)delegate
{
    NSLog(@"2");

    return [[_CLImageEditorViewController alloc] initWithImage:image delegate:delegate];
}

- (id)initWithDelegate:(id<CLImageEditorDelegate>)delegate
{
    NSLog(@"1");

    return [[_CLImageEditorViewController alloc] initWithDelegate:delegate];
}

- (void)showInViewController:(UIViewController*)controller withImageView:(UIImageView*)imageView;
{
    NSLog(@"1");

}
/**
- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image {
    

    NSLog(@"yii");
    UIImageWriteToSavedPhotosAlbum(image,
                                   nil,
                                   nil,
                                   nil);
    [editor dismissViewControllerAnimated:YES completion:nil];
    
}
**/



- (CLImageEditorTheme*)theme
{
    NSLog(@"1");

    return [CLImageEditorTheme theme];
}

- (void)presentImageEditorWithImage:(UIImage*)image
{
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    
    [self presentViewController:editor animated:YES completion:nil];

    //editor.delegate = self;[self presentViewController:editor animated:YES completion:nil];
}
/**
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"2");
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    //editor.delegate = self;
    
    [picker pushViewController:editor animated:YES];
}
**/
@end

