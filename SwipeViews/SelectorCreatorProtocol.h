//
//  SelectorCreatorProtocol.h
//  SwipeViews
//
//  Created by TouchROI on 12/28/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <Foundation/Foundation.h>


@import UIKit;
@class GlobalManager;
@protocol SelectorCreatorProtocol <NSObject>

-(NSArray*) controllers;
-(NSArray*) createNewControllers:(UIViewController*) controller;
-(void) handleFinish:(GlobalManager*) globalManager;

@end
