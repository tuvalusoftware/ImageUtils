//
//  ViewController.h
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;

 
#import "SwipePickBaseController.h"
#import "PhotoUtils.h"
#import "Configs.h"

@class ZLSwipeableView;
@class GridViewController;
@class CardView;


@interface TVSSwipPickControllerFinish : SwipePickBaseController  <FileInfoProtocol,FileDeleteProtocol,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property BOOL isStarted;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;

@property BOOL isConfirm;
@property (strong) UIButton* reviewButton;
@property (strong) UILabel * myLabel;
@property (strong) GridViewController *gridView;
@property (strong)  UINavigationController * navController;
@property (strong)  CardView  * cardView;
@property (strong)  NSMutableArray  * deleteArray;
@property BOOL noFilesSelected;

/* initialization method */
- (instancetype) initWithType:(DataType) type;
-(instancetype) initWithNibNameAndType:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  Type:(DataType) theType;
@end

