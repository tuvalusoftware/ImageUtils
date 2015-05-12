//
//  LabsLibrary.h
//  LabsLibrary
//
//  Created by Tim O'Brien on 10/14/14.
//  Copyright (c) 2014 ORG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "layout.h"

@interface LabsLibrary : NSObject


-(int) layout:(Photo*) photos  NumberP:(int) np CanvasWidth:(float) canvasWidth CanvasHeight:(float) canvasHeight Border:(float) border BackgroundColor:(int) bgcolor NumberGenerations:(int) ig;

@end
