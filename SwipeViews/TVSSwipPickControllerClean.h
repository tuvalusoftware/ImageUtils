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
#import "Configs.h"
@class ZLSwipeableView;
@class GridViewController;
@class CardView;

@interface TVSSwipePickControllerClean : SwipePickBaseController<UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *creationDate;
@property (strong) PHFetchResult *assetsFetchResults;
@property (strong) PHAssetCollection *assetCollection;
@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;
@property (strong, nonatomic)   GridViewController* gridView;
@property (strong) UINavigationController* navController;
@property (weak, nonatomic) IBOutlet UILabel *mbSelected;
@property (nonatomic) NSUInteger viewIndex;
@property CGRect previousPreheatRect;

@property (strong) NSArray* deletedArray;



-(void)  reload;
- (instancetype) initWithType:(DataType) type;

-(NSString*) rightLabelTitle;
-(NSString*) leftLabelTitle;
-(int) operationType;
-(void) process:(CardView*)card;
@end

