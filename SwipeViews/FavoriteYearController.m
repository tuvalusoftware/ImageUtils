//
//  FavoriteYearController.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "FavoriteYearController.h"

@implementation FavoriteYearController





- (instancetype)init
{
    self = [super initWithType:NumberOfPhotos];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerYear" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}


-(void) viewDidLoad
{
    
    [super viewDidLoad];
    
    
    
}



@end
