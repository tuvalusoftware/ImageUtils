//
//  TVSStartFavorite.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSStartFavorite.h"

@implementation TVSStartFavorite





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
    return NSLocalizedString(@"Favorite",@"favorite photos");
    
}


-(NSString*) mainLabelText
{
    return NSLocalizedString(@"Favorite Your Best Photos",@"remove unwanted photos")  ;
    
    
}


-(NSString*) alertText
{
    
    
    return NSLocalizedString(@"No Photos were found in your photos album",@"no photos were found");
}
-(BOOL) doCheck
{
     int i;
     NSArray * arrayOfInteger= [PhotoUtils getArrayOfYear:&i];
    return (!([arrayOfInteger count] ==0));
}

@end
