//
//  ViewController.m
//  SwipeViews
//
//  Created by TouchROI on 1/1/15.
//  Copyright (c) 2015 tim.obrien. All rights reserved.
//

#import "ViewController.h"
#import "CleanController.h"
#import "Configs.h"
@import Photos;
@import AssetsLibrary;


@interface ViewController ()

@end

@implementation ViewController

-(UIViewController*) controller
{
    return [CleanController new];
    
}
/*
#pragma mark - UIViewController  Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _cleanController = [CleanController new];
    self.view.backgroundColor= BASE_COLOR;
    [self.permissionBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    self.instructions.backgroundColor = BASE_COLOR;
    self.instructions.textColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button pressed

-(IBAction) OkBtnPressed:(id) button
{
    [self checkView];
    
    
}



-(void) viewWillAppear:(BOOL)animated
{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    self.permissionBtn.hidden = NO;
    self.instructions.hidden = NO;
    if (status == ALAuthorizationStatusAuthorized) {
        
         self.permissionBtn.hidden = YES;
         self.instructions.hidden = YES;
         [self.view addSubview:_cleanController.view];
    }
    
    
}


#pragma mark - check photo permissions
-(void) checkView
{
    
    
   // lets do a very quick check. this method is more performant 
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    if (status == ALAuthorizationStatusAuthorized) {
        self.permissionBtn.hidden = YES;
        self.instructions.hidden = YES;
        [self.view addSubview:_cleanController.view];
    }
    
    else if (status == ALAuthorizationStatusDenied)
    {
        [self showDeniedAlert];
    }
    else if  (status == ALAuthorizationStatusRestricted)
    {
        
        [self showRestrictedAlert];
        
    }
    else // ALAuthorizationStatusNotDetermined
    {
        
        
        
        
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            switch (status) {
                case PHAuthorizationStatusAuthorized:
                    self.permissionBtn.hidden = YES;
                    self.instructions.hidden = YES;
                    [self.view addSubview:_cleanController.view];
                    break;
                case PHAuthorizationStatusRestricted:
                    [self showRestrictedAlert];
                    break;
                case PHAuthorizationStatusDenied:
                    [self showDeniedAlert];
                    break;
                default:
                    break;
            }
        }];
    }
    
    
    
    
}


#pragma mark - alert methods
-(void) showDeniedAlert
{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:NSLocalizedString(@"Photo Permissions Failure",@"User not authorized to access photos in app")
                                                     message:  NSLocalizedString(@"Please set permissions in the Settings app",@"explanation on how where to set photo access permissions on the iphone")
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    
    [alert show];
    
    
}

-(void) showRestrictedAlert
{
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:NSLocalizedString(@"Photo Permissions Failure",@" ")
                                                     message: NSLocalizedString(@"Your access to Photos on this device have been restricted",@"Tell the users that permissions has been denied. The user cannot allow himself permsission using settings")
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    
    [alert show];
    
    
}


*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
