//
//  ViewController.h
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewPermissionControllerBase : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *instructions;
@property (weak, nonatomic) IBOutlet UIButton *permissionBtn;
@property (strong, nonatomic) IBOutlet UIViewController *controller;
-(UIViewController*) controller;



@end
