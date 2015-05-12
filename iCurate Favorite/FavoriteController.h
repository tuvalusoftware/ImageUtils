//
//  ViewController.h
//  iCurate Favorite
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TVSStartFavorite;
@class FavoriteYearController;
@class FavoriteMonthController;
@class GlobalManager;
@class FavoritePhotos;
@class FavoriteConfirm;
@class FavoriteFinish;
#import "SelectorCreatorProtocol.h"

@interface FavoriteController : UIViewController<SelectorCreatorProtocol>


@property (strong) TVSStartFavorite* favoriteStart;
@property (strong) FavoriteYearController* favoriteYearController;
@property (strong) FavoriteMonthController* favoriteMonthController;
@property (strong) FavoritePhotos * favoritePhotos;
@property (strong) FavoriteConfirm* favoriteConfirm;
@property (strong) FavoriteFinish* favoriteFinish;

@property (strong) GlobalManager* gManager;
@end

