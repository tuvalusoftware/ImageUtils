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
#import "Configs.h"

@interface TVSSwipeViewControllerMonth : SwipePickBaseController<ReloadProtocol>

@property (strong) NSArray* arrayOfString;
@property (strong) NSArray* arrayOfMonth;
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (nonatomic) NSUInteger viewIndex;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

-(void) reload;

/* initialize with nib name and type*/
- (instancetype)initWithNibNameAndType:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil DataType:(DataType) dataType;

- (instancetype)initWithType:(DataType) type;

@end
