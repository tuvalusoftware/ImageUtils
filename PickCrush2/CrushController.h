//
//  CrushController.h
//  iCurate Crush
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectorCreatorProtocol.h"
#import "FileDeleteProtocol.h"
#import "FileInfoProtocol.h"




@class CrushStartController;
@class CrushYearController;
@class CrushMonthController;
@class CrushPhotosController;
@class CrushControllerConfirm;
@class CrushControllerFinish;
@class GlobalManager;


@interface CrushController : UIViewController<SelectorCreatorProtocol,FileDeleteProtocol,FileInfoProtocol>


@property (strong) GlobalManager*          gManager;
@property (strong) CrushStartController* startController;
@property (strong) CrushYearController* yearController;
@property (strong) CrushMonthController * monthController;
@property (strong) CrushPhotosController* photosController;
@property (strong) CrushControllerConfirm* confirmController;
@property (strong) CrushControllerFinish* finishController;
@end

