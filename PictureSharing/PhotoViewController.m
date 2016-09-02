//
//  PhotoViewController.m
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/4/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import "PhotoViewController.h"
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

@interface PhotoViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *blogs;
@property (nonatomic) NSString *blogID;
@property (nonatomic) NSArray *photos;
@property (nonatomic) BOOL loading;
@property (nonatomic) CLImageEditor *editor;
@property (nonatomic) ImageViewController *master;
//@property (nonatomic) UIViewController *master;
@property (nonatomic) UIImage *pic;
@property (nonatomic) NSDictionary *selectedPhoto;
@property (nonatomic) UIImagePickerController *picker;
//@property (nonatomic) EditViewController *fix;


@end

@implementation PhotoViewController

//[SSKeychain setPassword:instagramToken forService:@"InstagramService" account:@"com.yourapp.keychain"];

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
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
            
            //self.picker = [[UIImagePickerController alloc] init];
            //self.editor = [[CLImageEditor alloc] initWithImage:image delegate:self.master];
            /**
            UIImageWriteToSavedPhotosAlbum(image,
                                           nil,
                                           nil,
                                           nil);
             **/
            self.master = [[ImageViewController alloc] initWithImage:image];
            //self.fix = [[EditViewController alloc] init];
            //[self segueForUnwindingToViewController:self.master fromViewController:self identifier:@"change"];
            
            
            
            
                    }];
//        
//        UIViewController* myViewController = [[UIStoryboard storyboardWithName:@"Main"  bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//        UIView* view = myViewController.view; //Get the view from your StoryBoard.
//
        //self.master = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] //instantiateViewControllerWithIdentifier:@"ImageViewController"];

        //[self segueForUnwindingToViewController: fromViewController:<#(UIViewController *)#> identifier:<#(NSString *)#>
        
        
        
//        
//            ImageViewController *view = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//        
//           [self.view.window.rootViewController presentViewController:view animated:YES completion:nil];
        
        
        [self.view.window.rootViewController presentViewController:self.master animated:YES completion:nil];
        //[self.view pushViewController:self.editor animated:YES];
        //[self.picker pushViewController:self.editor animated:YES];

        
        
         NSLog(@"image1: %@", self.pic);
        
        //[self.parentViewController presentViewController:self.editor animated:YES completion:nil];
        //[self.view.window.rootViewController.navigationController pushViewController:self.editor animated:YES];

        //[self presentViewController:view animated:YES completion:nil];
    }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil
                                                        image:[UIImage imageNamed:@"user_normal"]
                                                selectedImage:[UIImage imageNamed:@"user_pressed"]];
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

        
        [SimpleAuth authorize:@"tumblr" /**options: @{@"scope": @[@"likes"]}**/ completion:^(NSDictionary *responseObject, NSError *error) {
            NSLog(@"response: %@", responseObject);
            self.accessToken = responseObject[@"credentials"][@"token"];
             self.blogID = responseObject[@"extra"][@"raw_info"][@"blogs"][0][@"name"];
            NSLog(@"token: %@", self.accessToken);
            
            self.blogs = responseObject[@"extra"][@"raw_info"][@"blogs"];
            NSLog(@"blogs: %@", self.blogs);

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

    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.tumblr.com/v2/blog/%@.tumblr.com/posts/photo?api_key=%@", self.blogID, @"YsYwy8V8FvlBGbHFV9OFWokio8MsO6AygeCOecN5ywyxTk0AM6"];
    NSLog(@"name: %@", self.blogID);
    NSLog(@"token: %@", self.accessToken);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString *text = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"text: %@", text);
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.photos = [responseDictionary valueForKeyPath:@"response.posts"];
        NSLog(@"photos: %@", self.photos);
        
        NSLog(@"HEEEEEY");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            self.loading = NO;
        });
        
        NSLog(@"HEEEEEY2");
        
    }];
    [task resume];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
 
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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[PresentDetailTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[DismissDetailTransition alloc] init];
}

@end
