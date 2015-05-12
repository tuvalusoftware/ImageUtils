//
//  TVSSwipeViewControllerYear.h
//  PhotoSelector
//
//  Created by TouchROI on 11/25/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//


#import "SwipePickBaseController.h"
#import "ReloadProtocol.h"
#import "Configs.h"

@class ZLSwipeableView;

@interface TVSSwipeViewControllerYear : SwipePickBaseController<ReloadProtocol>

@property (strong) NSMutableArray* arrayOfInteger;
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (nonatomic) NSUInteger viewIndex;
@property  int  currentYear;
@property  BOOL hasStarted;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;


-(void) preloadYear;
-(void) reload;

/* initialize with nib name and type*/
- (instancetype)initWithNibNameAndType:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil DataType:(DataType) dataType;

- (instancetype)initWithType:(DataType) type;


@end
