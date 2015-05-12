//
//  SwipeViewControllerYear.h
//  PhotoSelector
//
//  Created by TouchROI on 11/25/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"
#import "SwipePickBaseController.h"
#import "ReloadProtocol.h"

@interface TVSSwipeViewControllerMonthNumFiles : SwipePickBaseController<ReloadProtocol>

@property (strong) NSArray* arrayOfString;
@property (strong) NSArray* arrayOfMonth;
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (nonatomic) NSUInteger colorIndex;
-(void) reload;

@end
