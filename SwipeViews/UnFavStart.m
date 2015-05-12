//
//  UnFavStart.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "UnFavStart.h"
#import "PHotoUtils.h"
@implementation UnFavStart



-(NSString*)btnTitle
{
    return NSLocalizedString(@"Scrub Favorites",@"favorite photos");
    
}
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

-(NSString*) mainLabelText
{
    return NSLocalizedString(@"Scrub Favorites Album",@"remove unwanted photos")  ;
    
}

-(NSString*) alertText
{
    
    
    return NSLocalizedString(@"No Photos were found in your favorites album",@"no photos were found");
}
-(BOOL) doCheck
{
    return [PhotoUtils hasFavorites];
}



@end
