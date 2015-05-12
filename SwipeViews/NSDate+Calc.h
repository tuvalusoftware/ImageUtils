//
//  NSDate+Calc.h
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calc)
+(NSDate*)lastDayOfMonth:(int) year Month:(int) month;
+(NSDate*)firstDayOfMonth:(int) year Month:(int) month;
+(NSDate*)lastDayOfMonthDate:(NSDate*) date;

@end
