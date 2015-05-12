//
//  ViewController.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "ViewController.h"
#import "CrushController.h"
#import "Configs.h"

@import Photos;
@import AssetsLibrary;

@interface ViewController ()

@end

@implementation ViewController

-(UIViewController*) controller
{
    return [CrushController new];
    
}
 

@end
