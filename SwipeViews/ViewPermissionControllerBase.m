//
//  ViewController.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "ViewPermissionControllerBase.h"
#import "CrushController.h"
#import "Configs.h"

@import Photos;
@import AssetsLibrary;

@interface ViewPermissionControllerBase ()

@end

@implementation ViewPermissionControllerBase


 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _controller = self.controller;
    self.view.backgroundColor= BASE_COLOR;
    [self.permissionBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    self.instructions.backgroundColor = BASE_COLOR;
    self.instructions.textColor = [UIColor whiteColor];
    
}


-(void) authorizationStatusDoNothing
{
    int status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
        case ALAuthorizationStatusAuthorized:
            [self transitionViews];
            break;
        case ALAuthorizationStatusDenied:
            ;
            break;
        case ALAuthorizationStatusRestricted:
            ;
            break;
        default:
            ;
            
    }
    
    
}


-(void) authorizationStatusDisplayDialog
{
    ALAssetsLibrary *library;
    int status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
        case ALAuthorizationStatusAuthorized:
            [self transitionViews];
            break;
        case ALAuthorizationStatusDenied:
           [self showDeniedAlert];
            break;
        case ALAuthorizationStatusRestricted:
            [self showRestrictedAlert];;
            break;
        case ALAuthorizationStatusNotDetermined:
           
             library = [[ALAssetsLibrary alloc] init];
            [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
 
                [self transitionViews];
   
            } failureBlock:^(NSError *error) {
                
                
            }];
            break;
            
            
    }
    
    
}

-(void) transitionViews
{
 
    

    _controller.view.alpha =0;
    [self.view addSubview:_controller.view];
    
    
    
    [UIView animateWithDuration:.4 animations:^{
        self.permissionBtn.hidden = YES;
        self.instructions.hidden = YES;
        
            self.view.alpha =1;
            _controller.view.alpha=1;
            
        }
    completion:^(BOOL finished){
        
        
        
        
    }];

   
}


-(void) viewWillAppear:(BOOL)animated
{
 
    self.permissionBtn.hidden = NO;
    self.instructions.hidden = NO;
    [self authorizationStatusDoNothing];
    
   /* if (status == ALAuthorizationStatusAuthorized) {
        [self.view addSubview:_controller.view];
    }*/
    
    
}





-(IBAction) OkBtnPressed:(id) button
{
    [self authorizationStatusDisplayDialog];
    
    
}


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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
