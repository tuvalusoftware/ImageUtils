//
//  ViewController.h
//  iCurate Clean
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectorCreatorProtocol.h"
#import "FileDeleteProtocol.h"
@class GlobalManager;
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
@interface CleanController : UIViewController<SelectorCreatorProtocol,FileDeleteProtocol>

@property (strong) GlobalManager* gManager;

/*list of controllers */
@property (strong) TVSStartWithDropdown            *  startDropdownController;
@property (strong) TVSDeleteStepsViewController    *  swipeableView;
@property (strong) TVSSwipPickControllerStart      *  startController;
@property (strong) TVSSwipPickControllerConfirm    *  confirmController;
@property (strong) TVSSwipeViewControllerMonth     *  monthController;
@property (strong) TVSSwipeViewControllerYear      *  yearController;
@property (strong) TVSSwipePickControllerClean     *  photoCleanController;
@property (strong) TVSSwipPickControllerFinish     *  finishController;


-(NSArray*) createNewControllers:(UIViewController*) controller;
-(NSArray*) controllers;
@end

