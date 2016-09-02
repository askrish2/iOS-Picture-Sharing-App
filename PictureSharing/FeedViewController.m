//
//  FeedViewController.m
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/10/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#define TAG_ALERT 1
#define TAG_ACTION 2

#import "FeedViewController.h"
#import "PhotoCell.h"
//import imglyKit;
#import "PhotoController.h"
#import "CLImageEditor.h"
#import "DetailViewController.h"
#import <SimpleAuth/SimpleAuth.h>
#import "PresentDetailTransition.h"
#import "DismissDetailTransition.h"
#import "ImageViewController.h"
#import "EditViewController.h"

@interface FeedViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *blogs;
@property (nonatomic) NSString *blogID;
@property (nonatomic) NSArray *photos;
@property (nonatomic) BOOL loading;
@property (nonatomic) NSString *tag;
@property (nonatomic) CLImageEditor *editor;
@property (nonatomic) ImageViewController *master;
//@property (nonatomic) UIViewController *master;
@property (nonatomic) UIImage *pic;
@property (nonatomic) NSDictionary *selectedPhoto;
@property (nonatomic) UIImagePickerController *picker;
//@property (nonatomic) EditViewController *fix;


@end

@implementation FeedViewController

//[SSKeychain setPassword:instagramToken forService:@"InstagramService" account:@"com.yourapp.keychain"];

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == TAG_ALERT) {
    self.tag = [[alertView textFieldAtIndex:0] text];
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
    [self refresh];
    }
    else {
    
    if (buttonIndex == 1) {
        NSLog(@"Clicked button index 1");
        // Add the action here
        DetailViewController *viewController = [[DetailViewController alloc] init];
        viewController.modalPresentationStyle = UIModalPresentationCustom;
        viewController.transitioningDelegate = self;
        viewController.photo = self.selectedPhoto;
        
        [self presentViewController:viewController animated:YES completion:nil];
        //[self.view.window.rootViewController presentViewController:viewController animated:YES completion:nil];
        
        
    }
    if (buttonIndex == 2){
        NSLog(@"Clicked button index 2");
        // Add another action here
        [PhotoController imageForPhoto:self.selectedPhoto size:@"original_size" completion:^(UIImage *image) {
            
            //NSLog(@"here: %@", self.editor.debugDescription);
            
            //self.pic = image;
            self.editor = [[CLImageEditor alloc] initWithImage:image];
            //WithImage:image
            //self.editor = [[CLImageEditor alloc] presentImageEditorWithImage:image];
            NSLog(@"image: %@", image);
        
            self.master = [[ImageViewController alloc] initWithImage:image];
            
        }];
        
        [self.view.window.rootViewController presentViewController:self.master animated:YES completion:nil];
        
        NSLog(@"image1: %@", self.pic);
  
    }
    }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"global_normal"]
                                                selectedImage:[UIImage imageNamed:@"global_pressed"]];
    }
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(124.0, 124.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    return (self = [super initWithCollectionViewLayout:layout]);
    //return self;
}

- (void)setLoading:(BOOL)loading {
    _loading = loading;
    
    self.navigationItem.rightBarButtonItem.enabled = !_loading;
}
/**
 - (instancetype) init {
 UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
 layout.itemSize = CGSizeMake(124.0, 124.0);
 layout.minimumInteritemSpacing = 1.0;
 layout.minimumLineSpacing = 1.0;
 return (self = [super initWithCollectionViewLayout:layout]);
 }
 **/
//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIAlertView * alert2 = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter a tag!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert2.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert2.tag = TAG_ALERT;
    [alert2 show];
    
    
    self.title = @"Picture Sharing";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //UNCOMMENT
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photo"];
    
    // Do any additional setup after loading the view.
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    self.blogID = [userDefaults objectForKey:@"blogID"];
    
    if (self.accessToken == nil) {
        
        //        [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
        //         NSString *accessToken = responseObject[@"credentials"][@"token"];
        //        [SSKeychain setPassword:accessToken forService:@"com.anujverma.Photo-Bombers" account:@"theUserName"];
        
        
        [SimpleAuth authorize:@"tumblr" /**options: @{@"scope": @[@"likes"]}**/ completion:^(NSDictionary *responseObject, NSError *error) {
            NSLog(@"response: %@", responseObject);
            self.accessToken = responseObject[@"credentials"][@"token"];
            self.blogID = responseObject[@"extra"][@"raw_info"][@"blogs"][0][@"name"];
            NSLog(@"token: %@", self.accessToken);
            
            self.blogs = responseObject[@"extra"][@"raw_info"][@"blogs"];
            NSLog(@"blogs: %@", self.blogs);
            
            //            for (int i=0; i<self.blogs.count; i++) {
            //            //select which blog to view
            //                if ([self.blogs[i][@"primary"]  isEqual: @"1"]) {
            //                    self.blogID = responseObject[@"extra"][@"raw_info"][@"blogs"][i][@"name"];
            //                    break;
            //                }
            //            }
            //self.blogID = responseObject[@"info"][@"blogs"][@"name"];
            NSLog(@"name: %@", self.blogID);
            
            [userDefaults setObject:self.blogID forKey:@"blogID"];
            [userDefaults setObject:self.accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            
            [self refresh];
        }];
    }
    else {
        [self refresh];
    }
    
    
}

- (void) refresh {
    if (self.loading) {
        return;
    }
    
    self.loading = YES;
    
    NSURLSession * session = [NSURLSession sharedSession];
    //NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/snow/media/recent?access_token=%@", self.accessToken];
    //NSString *blogName = responseObject[@"extra"][@"raw_info"][@"blogs"][0][@"name"];
    
    NSString *urlString;
    
    if (!self.tag) {
        urlString = [[NSString alloc] initWithFormat:@"https://api.tumblr.com/v2/tagged?tag=beach&api_key=%@", @"YsYwy8V8FvlBGbHFV9OFWokio8MsO6AygeCOecN5ywyxTk0AM6"];
    }
    else {
        urlString = [[NSString alloc] initWithFormat:@"https://api.tumblr.com/v2/tagged?tag=%@&api_key=%@", self.tag, @"YsYwy8V8FvlBGbHFV9OFWokio8MsO6AygeCOecN5ywyxTk0AM6"];
    }
    NSLog(@"name: %@", self.blogID);
    NSLog(@"token: %@", self.accessToken);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString *text = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"FEEEEDtext: %@", text);
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.photos = [responseDictionary valueForKeyPath:@"response"];
        NSLog(@"photos: %@", self.photos);
        
        NSLog(@"FEEEEED");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            self.loading = NO;
        });
        
        
    }];
    [task resume];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return 10;
    //log10(self.photos.count);
    return [self.photos count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.photo = self.photos[indexPath.row];
    
    return cell;
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pick an option!"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"View", @"Edit", nil];
    alert.tag = TAG_ACTION;
    [alert show];
    //[alert release];
    
    self.selectedPhoto = self.photos[indexPath.row];
    /**
     NSDictionary *photo = self.photos[indexPath.row];
     DetailViewController *viewController = [[DetailViewController alloc] init];
     viewController.modalPresentationStyle = UIModalPresentationCustom;
     viewController.transitioningDelegate = self;
     viewController.photo = photo;
     
     [self presentViewController:viewController animated:YES completion:nil];
     **/
}
/**
 - (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
 NSDictionary *photo = self.photos[indexPath.row];
 //CLImageEditor *editor;
 [PhotoController imageForPhoto:photo size:@"original_size" completion:^(UIImage *image) {
 self.editor = [[CLImageEditor alloc] initWithImage:image];
 }];
 [self presentViewController:self.editor animated:YES completion:nil];
 
 }
 **/
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentDetailTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[DismissDetailTransition alloc] init];
}

@end
