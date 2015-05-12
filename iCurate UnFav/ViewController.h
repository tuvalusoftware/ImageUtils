//
//  ViewController.h
//  iCurate UnFav
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnFavStart;
@class UnfavPhotos;
@class UnfavConfirm;
@class UnfavFinish;

@class GlobalManager;

#import "SelectorCreatorProtocol.h"
#import "ViewPermissionControllerBase.h"

@interface ViewController : ViewPermissionControllerBase


@property (strong) GlobalManager* gManager;

@property (strong) UnFavStart*      unfavStart;
@property (strong) UnfavPhotos*     unfavPhotos;
@property (strong) UnfavConfirm*    unfavConfirm;
@property (strong) UnfavFinish *    unfavFinish;
@end

