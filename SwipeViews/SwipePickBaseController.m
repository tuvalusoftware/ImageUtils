//
//  SwipePickBaseController.m
//  PhotoSelector
//
//  Created by TouchROI on 11/28/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "SwipePickBaseController.h"
#import "Configs.h"
#import "GlobalManager.h"



#define IMAGE_DIM 7


@interface SwipePickBaseController () 

 



@end

@implementation SwipePickBaseController



- (void)viewDidLoad {
    [super viewDidLoad];
      [self.view setBackgroundColor:BASE_COLOR];
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
       [self.view setBackgroundColor:BASE_COLOR];
    
  
    
    
    
}


-(GlobalManager*) manager
{
    
   return  [GlobalManager sharedInstance];
    
    
}

 



@end
