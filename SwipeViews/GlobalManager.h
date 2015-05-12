//
//  GlobalManager.h
//  SwipeViews
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Configs.h"
#import "SelectorCreatorProtocol.h"
@import UIKit;

@class DeleteStepsViewController;
@class AAPLRootListViewController;

@class TVSSwipPickControllerStart;
@class TVSTVSSwipPickControllerConfirm;
@class TVSSwipeViewControllerMonth;
@class TVSSwipeViewControllerYear;
@class TVSSwipPickController;
@class TVSStartWithDropdown;
@class STVStartWithDropdown;
@class TVSDeleteStepsViewController;
@class TVSSwipePickControllerClean;
@class TVSSwipPickControllerConfirm;
@class TVSSwipPickControllerFinish;


@interface GlobalManager : NSObject

 

 
//@property (strong) TVSSwipPickControllerConfirm    *  rateController;

/* controllers array */
@property (strong) NSArray            *  controllers;
@property (strong) NSArray            *  controllersR;


/* global data  */
@property int year;
@property int month;
@property NSString*  appId;
/* the main view */

@property (strong) UIView* view;
@property (weak) id<SelectorCreatorProtocol> parent;

/*global properties swiped to add and swiped to delete */
@property (strong) NSMutableArray* leftSwipeAssets;
@property (strong) NSMutableArray* rightSwipeAssets;
@property (strong) NSNumber* mbAggregate;
@property (strong) NSNumber*  mbAggregateDeleted;
@property (strong) NSMutableArray* assetRemoveArray;
@property int numberFilesExcluded;

/* init operations */
+ (id) sharedInstance:(FileOperation) operation View:(UIView*) view;
+ (id) sharedInstance;

-(void) loadView;
-(void) initializeView:(id<SelectorCreatorProtocol>) parent;


/* handle finish including delete, crush, ... other methods that used to be on the delegate*/
-(void) handleFinish;
-(void) clearAll;

@end
