//
//  UnfavPhotos.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "UnfavPhotos.h"
#import "PhotoUtils.h"
#import "UnFavStart.h"

@implementation UnfavPhotos


 

#pragma mark - initialization methods
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
    return 0;
}


-(PHFetchResult*) fetchAssets
{
   return  [PhotoUtils fetchFavorites];
    
}




#pragma mark - customizable methods
-(NSString*) rightLabelTitle
{
  
    
    return NSLocalizedString(@"Un-Favorite",@"Un-Forite photos (verb)");
}

-(NSString*) leftLabelTitle
{
    return NSLocalizedString(@"Show Next",@" show next photos (verb)");
    
}

@end
