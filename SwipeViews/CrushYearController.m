//
//  CrushYearController.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CrushYearController.h"

@implementation CrushYearController


- (instancetype)init
{
    self = [super initWithType:CrushedMegabytes];
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
