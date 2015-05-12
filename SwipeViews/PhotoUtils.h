//
//  PhotoUtils.h
//  PhotoSelector
//
//  Created by TouchROI on 11/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileInfoProtocol.h"
#import "FileDeleteProtocol.h"
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@import Photos;

@class  CardView;

@interface PhotoUtils : NSObject<MBProgressHUDDelegate>

+(void) photoSizeYear:(int)year   Result:(UIView<FileInfoProtocol>*)callbackView ParentView:(CardView*)parentView;
+(BOOL) hasPhotosYear:(int)year;
+(BOOL) hasPhotosMonth:(int)year  Month:(int)month;
+(void) photoSizeMonth:(int)year  Month:(int)month Result:(id<FileInfoProtocol>) callback ParentView:(UIView*)parentView;
+(void) photoSizeArrayOfPHAsset:(NSArray*) array Result:(id<FileInfoProtocol>)callback;
+(void) deletePhotos:(NSArray*) arrayOfPHAsset  Result:(id<FileDeleteProtocol>) callback;
+(void) favoritePhotos:(NSArray*) arrayOfPHAsset  Result:(id<FileDeleteProtocol>) callback;
+(void)  trueFilesSize:(PHAsset*) asset Result:(UIView<FileInfoProtocol>*)callbackView;
+ (void) countDownRemovedFile:(NSArray*) arrayOfFiles  Result:(UIView<FileInfoProtocol>*)callbackView;

/* uses an algorithm to reduce the size of the image */
+(void) crushImage:(PHAsset*) asset;
+(void) finishCrush:(NSArray*) arrayOfPHAsset  Result:(id<FileDeleteProtocol>) callback;
+(int) numberOfPhotosInMonth:(int)year  Month:(int)month;

+(NSArray*)  arrayOfMonth:(int) year;
+(int) numberOfPhotosInYear:(int)year;
+(BOOL) hasFavorites;


/* fetches an array of year and sets the current year*/
+(NSMutableArray*) getArrayOfYear:(int*) currentYear;


/* fetch images between dates*/
+(PHFetchResult*) getPhotosBetweenDates:(NSDate*) startDate  endDate:(NSDate*) endDate;
+(PHFetchResult*) fetchFavorites;

@end
