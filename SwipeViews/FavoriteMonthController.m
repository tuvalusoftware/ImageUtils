//
//  FavoriteMonthController.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "FavoriteMonthController.h"

@implementation FavoriteMonthController




- (instancetype)init
{
    self = [super initWithType:NumberOfPhotos];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerMonth" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}

@end
