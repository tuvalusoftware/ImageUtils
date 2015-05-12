//
//  SwipePickBaseController.h
//  PhotoSelector
//
//  Created by TouchROI on 11/28/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GlobalManager;

@interface SwipePickBaseController : UIViewController 

@property (strong) UIImageView* leftDotImage;
@property (strong) UIImageView* rightDotDotImage;

-(GlobalManager*) manager;


@end
