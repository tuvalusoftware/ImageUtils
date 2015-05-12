//
//  ViewController.m
//  iCurate UnFav
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "ViewController.h"
#import "UnFavStart.h"
#import "UnfavPHotos.h"
#import "UnfavConfirm.h"
#import "UnfavFinish.h"
#import "UnFavoriteController.h"
#import "GlobalManager.h"

 
@interface ViewController ()

@end

@implementation ViewController



-(UIViewController*) controller
{
    return  [UnFavoriteController new];
}


#pragma mark - Favorite finish method
-(void) handleFinish:(GlobalManager*) globalManager
{
    GlobalManager* gMansger = [GlobalManager sharedInstance];
    
    [PhotoUtils favoritePhotos:gMansger.leftSwipeAssets Result:self];
    
    
    
}






@end
