//
//  FavoriteConfirm.m
//  SwipeViews
//
//  Created by TouchROI on 12/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "FavoriteConfirm.h"
#import "Configs.h"
#import "GlobalManager.h"

@implementation FavoriteConfirm

- (instancetype)init
{
    self = [super initWithType:NumberOfPhotos];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerConfirm" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}


-(NSString*) leftBtnTitle
{
    
    return NSLocalizedString(@"Yes",@"un-favorite files ")  ;
    
}


-(NSString*) rightBtnTitle
{
    
    return NSLocalizedString(@"No",@"do nothing")  ;
    
}

-(NSString*) theText
{
    int count =  (int) ([self.manager.leftSwipeAssets count]-[self.manager.assetRemoveArray count])  ;
    
    if(count >0)
    {
        return [NSString localizedStringWithFormat:NSLocalizedString(@"favorite %i files?",nil) , count];
    }
    else{
        return NSLocalizedString(@"No Files Selected",nil);
        
    }
}

-(BOOL) isNotSelect
{
    return YES;
}

@end
