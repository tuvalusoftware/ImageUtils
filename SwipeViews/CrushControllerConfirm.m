//
//  CrushControllerConfirm.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CrushControllerConfirm.h"
#import "GlobalManager.h"

@implementation CrushControllerConfirm

- (instancetype)init
{
    self = [super initWithType:TotalMegabyte];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerConfirm" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



-(NSString*) leftBtnTitle
{
    
    return NSLocalizedString(@"Delete",@"un-favorite files ")  ;
    
}


-(NSString*) rightBtnTitle
{
    
    return NSLocalizedString(@"Cancel",@"do nothing")  ;
    
}


-(IBAction)aggregateUpdate:(NSNotification*)notifcation
{
    
    NSLog(@"got the message");
    
}

-(NSString*) theText
{
    int count =  (int) ([self.manager.leftSwipeAssets count]-[self.manager.assetRemoveArray count])  ;
    
    if(count >0)
    {
        return [NSString localizedStringWithFormat:NSLocalizedString(@"Delete Originals?",nil) , count];
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
