//
//  CrushControllerFinish.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CrushControllerFinish.h"

@implementation CrushControllerFinish



- (instancetype)init
{
    self = [super initWithType:TotalMegabyte];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerFinish" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}


-(NSString*) mainLabel
{
    return [NSString   localizedStringWithFormat:NSLocalizedString(@"Finished!",nil)];
    
}

@end
