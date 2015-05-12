//
//  ViewController.h
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;



#import "ReloadProtocol.h"
#import  "SwipePickBaseController.h"
@class ZLSwipeableView;



@interface TVSSwipPickControllerStart : SwipePickBaseController<ReloadProtocol>
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property BOOL isStarted;

@property (strong) UIImageView* leftDotImage;
@property (strong) UIImageView* rightDotDotImage;

@end

