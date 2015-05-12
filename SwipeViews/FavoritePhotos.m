//
//  FavoritePhotos.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "FavoritePhotos.h"


@implementation FavoritePhotos


- (instancetype)init
{
    self = [super initWithType:NumberOfPhotos];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerClean" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}



-(int) operationType
{
    return 1;
}

#pragma mark - customizable methods

 
-(NSString*) rightLabelTitle
{
  /*
     PHAsset *asset = self.assetsFetchResults[self.viewIndex];
    if(asset.favorite)
    {
        
          return NSLocalizedString(@"Un-Favorite",@"unforite photos (verb)");
        
    }
    else
    {
      return NSLocalizedString(@"Favorite",@"favorite photos (verb)");
        
        
    }
   */
    return @"none";
    
}

-(NSString*) leftLabelTitle
{
    return NSLocalizedString(@"Show Next",@"(un)favorite photos (verb)");
    
}

@end
