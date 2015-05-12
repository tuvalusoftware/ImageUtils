//
//  CrushMonthController.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CrushMonthController.h"

@implementation CrushMonthController


- (instancetype)init
{
    self = [super initWithType:CrushedMegabytes];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerMonth" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}

@end
