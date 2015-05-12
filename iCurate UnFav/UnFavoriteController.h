//
//  UnFavoriteController.h
//  SwipeViews
//
//  Created by TouchROI on 1/2/15.
//  Copyright (c) 2015 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>


@class UnFavStart;
@class UnfavPhotos;
@class UnfavConfirm;
@class UnfavFinish;
@class GlobalManager;

#import "SelectorCreatorProtocol.h"
#import "FileDeleteProtocol.h"

@interface UnFavoriteController : UIViewController<SelectorCreatorProtocol,FileDeleteProtocol>

@property (strong) GlobalManager* gManager;
@property (strong) UnFavStart*      unfavStart;
@property (strong) UnfavPhotos*     unfavPhotos;
@property (strong) UnfavConfirm*    unfavConfirm;
@property (strong) UnfavFinish *    unfavFinish;


@end
