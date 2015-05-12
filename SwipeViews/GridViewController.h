//
//  GridViewController.h
//  PhotoSelector
//
//  Created by TouchROI on 11/24/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AAPLAssetGridViewController;

@interface GridViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *gridView;

@property (strong) AAPLAssetGridViewController *gridController;
@property (strong) NSMutableSet* assetsForDelete;
-(void) initWithArray:(NSMutableArray*) array RemoveSet:(NSMutableSet*) set;
@property (strong) UIBarButtonItem *doneBtn;
@property BOOL isReview;
-(instancetype)initWithNibNameAndSelect:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Select:(BOOL) isNotSelect;
@end
