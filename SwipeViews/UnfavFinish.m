//
//  UnfavFinish.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "UnfavFinish.h"

@implementation UnfavFinish



- (instancetype)init
{
    self = [super initWithType:NumberOfPhotos];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerFinish" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}
-(NSString*) mainLabel
{
    return [NSString   localizedStringWithFormat:NSLocalizedString(@"Done!",nil)];
    
}


@end
