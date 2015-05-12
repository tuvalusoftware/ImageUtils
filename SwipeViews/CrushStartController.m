//
//  CrushStartController.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CrushStartController.h"

@implementation CrushStartController


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSStartWithDropdown" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}



-(void) viewDidload
{
    [super viewDidLoad];
}

-(NSString*)btnTitle
{
    return NSLocalizedString(@"Crush",@"favorite photos");
    
}


-(NSString*) mainLabelText
{
    return NSLocalizedString(@"Compress Your Photos",@"remove unwanted photos")  ;
    
}


-(NSString*) alertText
{
    return NSLocalizedString(@"No Photos were found",@"no photos were found");
}



-(BOOL) doCheck
{
    int i;
    NSArray * arrayOfInteger= [PhotoUtils getArrayOfYear:&i];
    return (!([arrayOfInteger count] ==0));
}



@end
