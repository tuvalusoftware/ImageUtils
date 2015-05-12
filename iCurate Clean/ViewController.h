//
//  ViewController.h
//  SwipeViews
//
//  Created by TouchROI on 1/1/15.
//  Copyright (c) 2015 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPermissionControllerBase.h"
 
@interface ViewController : ViewPermissionControllerBase
@property (weak, nonatomic) IBOutlet UILabel *instructions;
@property (weak, nonatomic) IBOutlet UIButton *permissionBtn;
@end
