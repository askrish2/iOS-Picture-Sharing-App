//
//  ImageViewController.m
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/9/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import "ImageViewController.h"

#import "CLImageEditor.h"

@interface ImageViewController ()
<CLImageEditorDelegate, CLImageEditorTransitionDelegate, CLImageEditorThemeDelegate>
//@property (strong, nonatomic) IBOutlet UIView *mainImageView;
//@property (weak, nonatomic) IBOutlet UITabBar *tabMenu;

@end
@implementation ImageViewController


- (void)viewDidLoad
{
    
    [super viewDidLoad];
   

  //  tabMenu.delegate=self;
   // [self.view addSubview:tabMenu];
    
   // [self.view addSubview:_imageView];

//    tabMenu.delegate=self;
//    [self.view addSubview:tabMenu];
//    
//    //_scrollView.delegate=self;
//    //[self.view addSubview:_scrollView];
//    
//    [self.view addSubview:_imageView];
   // [self.view addSubview:mainView];
    
    //[self.view sendSubviewToBack:self.view];
//     self.view = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
    
//    [self.view addSubview: [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"]];

    
    //[[NSBundle mainBundle] loadNibNamed:@"mainImageView" owner:self options:nil];
    UITabBar *tabMenu = [[UITabBar alloc] initWithFrame:CGRectMake(0, 600, 400, 49)];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(800, 800, 380, 400)];

    
    //tabMenu.
    
    tabMenu.delegate=self;
    [self.view addSubview:tabMenu];
    [self.view addSubview:_scrollView];
    [self.view addSubview:_imageView];
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
    
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"New" image:[UIImage imageNamed:@"new"] tag:0];
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Edit" image:[UIImage imageNamed:@"edit"] tag:1];
    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Save" image:[UIImage imageNamed:@"save"] tag:2];
    
    [tabBarItems addObject:tabBarItem1];
    [tabBarItems addObject:tabBarItem2];
    [tabBarItems addObject:tabBarItem3];
    
    tabMenu.items = tabBarItems;
    tabMenu.selectedItem = [tabBarItems objectAtIndex:0];
    //_imageView.image = [UIImage imageNamed:@"like"];
    
    //[self.mainImageView lo];
    //[self.view.window.rootViewController presentViewController:self.mainImageView animated:YES completion:nil];
    //_imageView.image = image;
    //[self storyboard];
    /**
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pick an option!"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"New", @"Edit", nil];
    [alert show];
    **/
    
    //UITabBar * tab = [[UITabBar alloc] init];
    /**
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UITabBarController *tabController = [[UITabBarController alloc] init];
    
    //UIViewController *viewController1 = [[UIViewController alloc] init];
    UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:@"Artists" image:[UIImage imageNamed:@"like"] tag:1];
   
    
    ///UIViewController *viewController2 = [[UIViewController alloc] init];
    UITabBarItem *tab2 = [[UITabBarItem alloc] initWithTitle:@"Music" image:[UIImage imageNamed:@"comment"] tag:2];
    
    
    //tabController.viewControllers = [NSArray arrayWithObjects:viewController1,
                                     //viewController2, nil];
    
    
    self.window.rootViewController = tabController;
    **/
    
    
    
    //Set a black theme rather than a white one
    /*
     [[CLImageEditorTheme theme] setBackgroundColor:[UIColor blackColor]];
     [[CLImageEditorTheme theme] setToolbarColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
     [[CLImageEditorTheme theme] setToolbarTextColor:[UIColor whiteColor]];
     [[CLImageEditorTheme theme] setToolIconColor:@"white"];
     [[CLImageEditorTheme theme] setStatusBarStyle:UIStatusBarStyleLightContent];
     [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
     */
//    
//    ImageViewController *view = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//    
//    [self presentViewController:view animated:NO completion:nil];
    
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 390, 44)];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:button];
    
    navigationItem.leftBarButtonItem = buttonItem;
 
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    [self.view addSubview:navigationBar];
    
    
    
    [self refreshImageView];
}

- (void) buttonClicked {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
//    ImageViewController *view = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//    
//    [self.view.window.rootViewController presentViewController:view animated:YES completion:nil];
    
    
//    ImageViewController *view = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//    
//    [self.view.window.rootViewController presentViewController:view animated:YES completion:nil];
    

    
    //_scrollView.delegate=self;
    //[self.view addSubview:_scrollView];
    
    //[self.view addSubview:_imageView];
    /**
    tabMenu.delegate=self;
    [self.view addSubview:tabMenu];
    
    [self.view addSubview:_imageView];
     **/
    /**
    ImageViewController *view = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
    
    
    [self presentViewController:view animated:NO completion:nil];
    **/
   
    

}

- (void) viewDidLayoutSubviews {
    
//    [super viewDidLayoutSubviews];
//    ImageViewController *view = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//    
//    [self presentViewController:view animated:NO completion:nil];
    
//    tabMenu.delegate=self;
//    [self.view addSubview:tabMenu];
//    
//    [self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)pushedNewBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Library", nil];
    [sheet showInView:self.view.window];
}

- (void)pushedEditBtn
{
    NSLog(@"image: %@", _imageView.image);
    
    if(_imageView.image){
        CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:_imageView.image delegate:self];
        //CLImageEditor *editor = [[CLImageEditor alloc] initWithDelegate:self];
        
        /*
         NSLog(@"%@", editor.toolInfo);
         NSLog(@"%@", editor.toolInfo.toolTreeDescription);
         
         CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLToneCurveTool" recursive:NO];
         tool.available = NO;
         
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLRotateTool" recursive:YES];
         tool.available = NO;
         
         tool = [editor.toolInfo subToolInfoWithToolName:@"CLHueEffect" recursive:YES];
         tool.available = NO;
         */
        
        [self presentViewController:editor animated:YES completion:nil];
        //[editor showInViewController:self withImageView:_imageView];
    }
    else{
        [self pushedNewBtn];
    }
}

- (void)pushedSaveBtn
{
    if(_imageView.image){
        NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage];
        
        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image] applicationActivities:nil];
        
        activityView.excludedActivityTypes = excludedActivityTypes;
        activityView.completionHandler = ^(NSString *activityType, BOOL completed){
            if(completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        };
        
        [self presentViewController:activityView animated:YES completion:nil];
    }
    else{
        [self pushedNewBtn];
    }
}

#pragma mark- ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [picker pushViewController:editor animated:YES];
}
/*
 - (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
 {
 if([navigationController isKindOfClass:[UIImagePickerController class]] && [viewController isKindOfClass:[CLImageEditor class]]){
 viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonDidPush:)];
 }
 }
 
 - (void)cancelButtonDidPush:(id)sender
 {
 [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
 }
 */
#pragma mark- CLImageEditor delegate

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    _imageView.image = image;
    [self refreshImageView];
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    [self refreshImageView];
}

#pragma mark- Tapbar delegate

- (void)deselectTabBarItem:(UITabBar*)tabBar
{
    tabBar.selectedItem = nil;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self performSelector:@selector(deselectTabBarItem:) withObject:tabBar afterDelay:0.2];
    
    switch (item.tag) {
        case 0:
            [self pushedNewBtn];
            break;
        case 1:
            [self pushedEditBtn];
            break;
        case 2:
            [self pushedSaveBtn];
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        
        NSLog(@"index: %ld", (long)buttonIndex);
        
        [self pushedNewBtn];
    }
    if (buttonIndex==2) {
         NSLog(@"index: %ld", (long)buttonIndex);
        
        [self pushedEditBtn];
    }
    if (buttonIndex==3) {
        
         NSLog(@"index: %ld", (long)buttonIndex);
        [self pushedSaveBtn];
    }
    
}






#pragma mark- Actionsheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex){
        return;
    }
    
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        if(buttonIndex==0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            type = UIImagePickerControllerSourceTypeCamera;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = NO;
        picker.delegate   = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark- ScrollView

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView.superview;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _imageView.superview.frame.size.width;
    CGFloat H = _imageView.superview.frame.size.height;
    
    CGRect rct = _imageView.superview.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _imageView.superview.frame = rct;
}

- (void)resetImageViewFrame
{
    CGSize size = (_imageView.image) ? _imageView.image.size : _imageView.frame.size;
    CGFloat ratio = MIN(_scrollView.frame.size.width / size.width, _scrollView.frame.size.height / size.height);
    CGFloat W = ratio * size.width;
    CGFloat H = ratio * size.height;
    _imageView.frame = CGRectMake(0, 0, W, H);
    _imageView.superview.bounds = _imageView.bounds;
}

- (void)resetZoomScaleWithAnimate:(BOOL)animated
{
    CGFloat Rw = _scrollView.frame.size.width / _imageView.frame.size.width;
    CGFloat Rh = _scrollView.frame.size.height / _imageView.frame.size.height;
    
    //CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat scale = 1;
    Rw = MAX(Rw, _imageView.image.size.width / (scale * _scrollView.frame.size.width));
    Rh = MAX(Rh, _imageView.image.size.height / (scale * _scrollView.frame.size.height));
    
    _scrollView.contentSize = _imageView.frame.size;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = MAX(MAX(Rw, Rh), 1);
    
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:animated];
    [self scrollViewDidZoom:_scrollView];
}

- (id)initWithImage:(UIImage*)image {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 68, 252, 280)];
    _imageView.image = image;
    [_imageView.image drawInRect:CGRectMake((self.view.frame.size.width/2) - (image.size.width/2),
                                 (self.view.frame.size.height / 2) - (image.size.height / 2),
                                 image.size.width,
                                 image.size.height)];
      NSLog(@"yyy:%@", image);
    
    
    
  
    /**
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pick an option!"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"New", @"Edit", nil];
    [alert show];
    **/
    [self refreshImageView];
  
    
    return self;
}

- (void)refreshImageView
{
    [self resetImageViewFrame];
    [self resetZoomScaleWithAnimate:NO];
}

@end