//
//  PhotoUtils.m
//  PhotoSelector
//
//  Created by TouchROI on 11/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "PhotoUtils.h"
#import "NSDate+Calc.h"
#import "FileInfoProtocol.h"

#import "FileDeleteProtocol.h"
#import "MBProgressHUD.h"

#import "UIImage+Resize.h"
#import "PHAsset+AssetUtil.h"
#import "CardView.h"
//#import "ImageProcessing.h"


@import Photos;

@implementation PhotoUtils



+(void) handleException:(NSException*) exception
{
    NSDictionary* dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                exception, @"exception",nil];
    
    
    NSNotification *notification =
    [NSNotification notificationWithName:@"Exception"  object:self userInfo:dictionary];
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostNow];
    
    
}



 




+(PHFetchResult*) fetchFavorites
{
    PHFetchResult* fetchResults=nil;
    
    @try {
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate predicateWithFormat:@"favorite==1"];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
       fetchResults= [PHAsset fetchAssetsWithOptions:options];
        
    }
    @catch (NSException *exception) {
        
        [PhotoUtils handleException:exception];
       
    }
    @finally {
        return  fetchResults;
    }

    
    
    
}
/* fetch images between dates*/
+(PHFetchResult*) getPhotosBetweenDates:(NSDate*) startDate  endDate:(NSDate*) endDate
{
    PHFetchResult * fetchResult = nil;
    @try {
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                startDate , endDate ];
        
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        
       fetchResult= [PHAsset fetchAssetsWithOptions:options];
    }
    @catch (NSException *exception) {
       [PhotoUtils handleException:exception];
    }
    @finally {
        return fetchResult;
    }
}

/* fetches an array of year and sets the current year*/
+(NSMutableArray*) getArrayOfYear:(int*) currentYear
{
  
    NSMutableArray* arrayOfYear = [[NSMutableArray alloc] init];
    
    @try {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        
        // fetch the present year
        int thisYear = [components year];
        
        
        int year  =-1;
        
        // count back 10 years from the current year looking for photos
        for(int i=0; i < 10; i++)
        {
            if( [PhotoUtils hasPhotosYear:thisYear-i] )
            {
                // the most recent year containing photos
                if(year ==-1)
                    year  = thisYear-i;
                
                // add to the list of years with photos
                NSNumber* number = [NSNumber numberWithInt:thisYear-i];
                [arrayOfYear addObject:number];
            }
        }
        
        *currentYear=year;
    }
    @catch (NSException *exception) {
        [PhotoUtils handleException:exception];
    }
    @finally {
          return arrayOfYear;
    }
    
    
    
  
    
}
/*

+(void) crushImage:(PHAsset*) asset
{
    
  
 
    
   
    // PHFetchResult*  fetchResult = [PHAssetCollection fetchAssetCollectionsContainingAsset:asset withType:PHAssetCollectionTypeAlbum options:nil];
    
    
    
    @try {
        // fetch the uiImage;
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageDataForAsset:asset
                                  options:nil
                            resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info)
         {
             
             
             
             UIImage *image = [UIImage imageWithData:imageData];
             
             //resize the image -does not actually change the size
             ImageProcessing * ip =  [[ImageProcessing alloc] init];
             UIImage * newImage = [ip resize:image Size:CGSizeMake(40, 40)];
             
             // now lets change the actual size of the image
             UIImage* aImage  = [UIImage imageWithImage:newImage scaledToFillToSize:CGSizeMake(newImage.size.width/3, newImage.size.height/3)];
             
             
             __block PHAssetChangeRequest *changeRequest =nil;
             
             
             
             
             [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                 
                 changeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:aImage];
                 
                 
                 [asset setAssociatedObject:changeRequest.placeholderForCreatedAsset.localIdentifier];
                 
                 
                 //NSLog(@"local identifier %@", changeRequest.placeholderForCreatedAsset.localIdentifier);
                 
                 
             } completionHandler:^(BOOL success, NSError *error) {
                 
                 
                 
                 
             }];
             
         }];
        
    }
    @catch (NSException *exception) {
        
         [PhotoUtils handleException:exception];
    }
    @finally {
        
    }
    
   
    
   
  
    
    
    
    /*
     PHContentEditingInputRequestOptions *options = [[PHContentEditingInputRequestOptions alloc] init];
     [options setCanHandleAdjustmentData:^BOOL(PHAdjustmentData *adjustmentData) {
     return [adjustmentData.formatIdentifier isEqualToString:AdjustmentFormatIdentifier] && [adjustmentData.formatVersion isEqualToString:@"1.0"];
     }];*/
    
    /*
    
    
     [self.asset requestContentEditingInputWithOptions:options completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
     // Get full image
     NSURL *url = [contentEditingInput fullSizeImageURL];
     int orientation = [contentEditingInput fullSizeImageOrientation];
     CIImage *inputImage = [CIImage imageWithContentsOfURL:url options:nil];
     //
     //UIImage* tmpImage = [[UIImage alloc] initWithCIImage:inputImage];
     inputImage = [inputImage imageByApplyingOrientation:orientation];
     
     UIImage * testImage = [UIImage imageWithCIImage:inputImage];
     
     
     CIFilter *scaleFilter = [CIFilter filterWithName:@"CILanczosScaleTransform"];
     [scaleFilter setValue:inputImage forKey:@"inputImage"];
     [scaleFilter setValue:[NSNumber numberWithFloat:.5] forKey:@"inputScale"];
     [scaleFilter setValue:[NSNumber numberWithFloat:1.0] forKey:@"inputAspectRatio"];
     CIImage *finalImage = [scaleFilter valueForKey:@"outputImage"];
     
     testImage = [UIImage imageWithCIImage:finalImage];
     
     
     
     // ImageProcessing * ip =  [[ImageProcessing alloc] init];
     // UIImage * newImage = [ip resize:tmpImage Size:CGSizeMake(40, 40)];
     
     
     
     
     ///UIImage * iImage = [[UIImage alloc] initWithCIImage:inputImage scale:7 orientation:UIImageOrientationUp];
     
     
     NSData *jpegData =  [finalImage aapl_jpegRepresentationWithCompressionQuality:0.9];
     
     PHAdjustmentData *adjustmentData = [[PHAdjustmentData alloc] initWithFormatIdentifier:AdjustmentFormatIdentifier formatVersion:@"1.0" data:[@"CILanczosScaleTransform" dataUsingEncoding:NSUTF8StringEncoding]];
     
     PHContentEditingOutput *contentEditingOutput = [[PHContentEditingOutput alloc] initWithContentEditingInput:contentEditingInput];
     
     NSURL* myurl  =  [contentEditingOutput renderedContentURL];
     
     BOOL didWrite =  [jpegData writeToURL:myurl atomically:YES];
     
     
     
     [contentEditingOutput setAdjustmentData:adjustmentData];
     
     [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
     PHAssetChangeRequest *request = [PHAssetChangeRequest changeRequestForAsset:self.asset];
     request.contentEditingOutput = contentEditingOutput;
     } completionHandler:^(BOOL success, NSError *error) {
     if (!success) {
     //NSLog(@"Error: %@", error);
     }
     }];
     }];
    
    */
    
   
//}

+(int) numberOfPhotosInYear:(int)year
{
    int retVal;
    
    @try {
        NSDate* date = [NSDate firstDayOfMonth:year Month:1];
        NSDate*  date2 = [NSDate lastDayOfMonth:year Month: 12];
        
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                date2, date ];
        
        
        
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        
       retVal =  [assetsFetchResults count];
    }
    @catch (NSException *exception)
    {
        
       [PhotoUtils handleException:exception];
    }
    @finally {
        return retVal;
    }
    
    
}

+(int) numberOfPhotosInMonth:(int)year  Month:(int)month
{
    
    
    int retVal;
    
    @try {
        NSDate* date = [NSDate firstDayOfMonth:year Month:month];
        NSDate*  date2 = [NSDate lastDayOfMonth:year Month: month];
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                date2, date ];
        
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        retVal = [assetsFetchResults count];
        
    }
    @catch (NSException *exception) {
        
         [PhotoUtils handleException:exception];
    }
    @finally {
        return retVal;
    }

  
    
}


+(BOOL) hasPhotosYear:(int)year
{
    
    BOOL retVal;
    
    @try {
        NSDate* date = [NSDate firstDayOfMonth:year Month:1];
        NSDate*  date2 = [NSDate lastDayOfMonth:year Month: 12];
        
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                date2, date ];
        
        
        
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        
        if( [assetsFetchResults count] > 0)
        {
           retVal =  YES;
            
        }
        else
        {
            retVal = NO;
            
        }
    }
    @catch (NSException *exception) {
        
          [PhotoUtils handleException:exception];
    }
    @finally {
        return retVal;
    }

    
}

+(NSArray*)  arrayOfMonth:(int) year
{
    
    
    NSArray * retArray = nil;
    
    @try {
        
        NSMutableArray * resultsArray = [[NSMutableArray alloc] init];
        
        NSDate* date = [NSDate firstDayOfMonth:year Month:1];
        NSDate*  date2 = [NSDate lastDayOfMonth:year Month: 12];
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                date2, date ];
        
        
        
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        PHAsset *asset;
        for(  asset in assetsFetchResults)
        {
            if(!asset.mediaType== PHAssetMediaTypeImage  && !asset.mediaType== PHAssetMediaTypeVideo )
                continue;
            
            NSDate*  cDate = asset.creationDate;
            NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth  fromDate:cDate];
            NSInteger month = [components month];
            
            NSNumber * number = [NSNumber numberWithInt:month];
            
            if(![resultsArray containsObject:number])
            {
                [resultsArray addObject:number];
            }
            
        }
        
     
        
        retArray = resultsArray;
    }
    @catch (NSException *exception)
    {
        [PhotoUtils handleException:exception];
    }
    @finally {
        return retArray;
    }



    
    
}

+(BOOL) hasFavorites
{
    
    BOOL retVal;
    
    @try {
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate predicateWithFormat:@"favorite==1"];
        PHFetchResult *assetsFetchResult = [PHAsset fetchAssetsWithOptions:options];
        
        retVal = ([assetsFetchResult count] > 0);
    }
    @catch (NSException *exception)
    {
        
          [PhotoUtils handleException:exception];
    }
    @finally {
        return retVal;
    }
    
  
 
}

+(BOOL) hasPhotosMonth:(int)year  Month:(int)month
{
    
    BOOL retVal;
    
    @try {
        
        NSDate* date = [NSDate firstDayOfMonth:year Month:month];
        NSDate*  date2 = [NSDate lastDayOfMonth:year Month: month];
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                date2, date ];
        
        
        
        // options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        
        
        
        PHAsset *asset;
        
        
        
        
        for(  asset in assetsFetchResults)
        {
            if( asset.mediaType== PHAssetMediaTypeImage  || asset.mediaType== PHAssetMediaTypeVideo )
               retVal =YES;
        }
        
        retVal= NO;
    }
    @catch (NSException *exception) {
        
         [PhotoUtils handleException:exception];
    }
    @finally {
        return retVal;
    }

 
    
}


+(void) finishCrush:(NSArray*) arrayOfPHAsset  Result:(id<FileInfoProtocol>) callback
{
   
    @try {
        PHAsset * asset;
        
        for(asset in arrayOfPHAsset)
        {
            NSString* assetId = (NSString*) [asset associatedObject];
            
            if(assetId)
            {
                PHFetchResult* result = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil];
                PHAsset * crushedAsset = [result firstObject];
                PHFetchResult*  fetchResult = [PHAssetCollection fetchAssetCollectionsContainingAsset:asset withType:PHAssetCollectionTypeAlbum options:nil];
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    
                    PHAssetChangeRequest *request = [PHAssetChangeRequest changeRequestForAsset:crushedAsset];
                    [request setFavorite: asset.favorite];
                    [request setCreationDate:asset.creationDate];
                    
                    PHAssetCollection * collection;
                    for(collection in fetchResult)
                    {
                        PHAssetCollectionChangeRequest * changeRequest= [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
                        [changeRequest addAssets:@[crushedAsset]];
                    }
                    
                    
                    
                } completionHandler:^(BOOL success, NSError *error) {
                    
                    
                    if (!success) {
                        
                     
                    }
                    else
                    {
                        
                        
                    }
                }];
                
            }
            
        }
        
      
        
    }
    @catch (NSException *exception) {
        
         [PhotoUtils handleException:exception];
    }
    @finally {
        
          [callback filesCrusshed];
    }
    

    
}

 

+(void) photoSizeArrayOfPHAsset:(NSArray*) array Result:(id<FileInfoProtocol>)callback
{
    
    @try {
         [callback fileAggregate:[array count] * 1.3];
    }
    @catch (NSException *exception) {
           [PhotoUtils handleException:exception];
    }
    @finally {
        // do nothing;
    }
    
    
  
   
    /*
    PHAsset * asset;
    
    for(  asset in array)
    {
        
        
        
        
        
        if(asset.mediaType== PHAssetMediaTypeImage)
        {
            //NSLog(@"image");
        }
        else if(asset.mediaType== PHAssetMediaTypeVideo)
        {
            //NSLog(@"video");
        }
        else{
            
            //NSLog(@"other");
        }
        
        
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            float imageSize = imageData.length;
            
            imageSize = imageSize/(1024*1024);
            imageSize = ceil(MAX(imageSize,1));
            [callback fileAggregate:imageSize];
            
        }];
        
        
        
    }
    
    
   */
}




+(void)  trueFilesSize:(PHAsset*) asset Result:(UIView<FileInfoProtocol>*)callbackView
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        @try {
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                float imageSize = imageData.length;
                
                imageSize = imageSize/(1024*1024);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [callbackView trueFilesSize:imageSize];
                });
            }];
        }
        @catch (NSException *exception) {
               [PhotoUtils handleException:exception];
        }
        @finally {
            // do nothing
        }
        
    });

}

-(NSString*) formatNumber:(float) size
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:size]];
    NSString * resStr = [NSString stringWithFormat:@"%@ MB",numberString];
    
    return resStr;
}



+ (void) countDownRemovedFile:(NSArray*) arrayOfFiles  Result:(UIView<FileInfoProtocol>*)callbackView
{
    
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        @try {
            
            float imageSize=0;
            PHAsset *asset;
            for(asset in arrayOfFiles)
            {
                
                
                [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                    float imageSize = imageData.length;
                    
                    imageSize = imageSize/(1024*1024);
                    
                    
                    
                }];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [callbackView filesRemovedOfSize:imageSize];
                });
            }
        }
        @catch (NSException *exception) {
            
                   [PhotoUtils handleException:exception];
        }
        @finally {
            // do nothing
        }
        
        

        
    });
    
 
    
}



+(void) photoSizeYear:(int)year   Result:(UIView<FileInfoProtocol>*)callbackView ParentView:(CardView*)parentView;
{
    PHFetchResult *assetsFetchResults;
    
    @try {
        NSDate*  date  = [NSDate firstDayOfMonth:year Month:1];
        NSDate*  date2 = [NSDate lastDayOfMonth:year Month: 12];
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                date2, date ];
        
        
        
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    }
    @catch (NSException *exception) {
         [PhotoUtils handleException:exception];// do nothing
    }
    @finally {
        // do nothing
    }
    
    
    @try {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [callbackView fileSize:[assetsFetchResults count]*1.3  ];
        });
    }
    @catch (NSException *exception) {
         [PhotoUtils handleException:exception];// do nothing
    }
    @finally {
        // do nothing
    }

    
    
    
  /*
    return;
    
  
    
    
 
   
    PHImageManager * manager = [PHImageManager defaultManager];
    
 
    // not that this code makes assumptions on the superview
   __block  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView   animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = NSLocalizedString(@"Calculating Space", @"running program to sum the space on hard drive");
    hud.color =  [UIColor colorWithRed:54.0f/255.0f
                                 green:205.0f/255.0f
                                  blue:253.0f/255.0f
                                 alpha:1];


    
    __block int hudCounter = [assetsFetchResults count];
    
    for(  asset in assetsFetchResults)
    {
        
        
       
        
        
        if(asset.mediaType== PHAssetMediaTypeImage)
        {
            //NSLog(@"image  " );
        }
        else if(asset.mediaType== PHAssetMediaTypeVideo)
        {
            //NSLog(@"video");
        }
        else{
            
            //NSLog(@"other");
        }
        
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
           
            
            
        [manager requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            float imageSize = imageData.length;
            //convert to Megabytes
            imageSize = imageSize/(1024*1024);
            
            imageSize = ceil(MAX(imageSize,1));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                 [callbackView fileSize:imageSize];
                
               // hudCounter--;
               // if(hudCounter ==0)
               // {
                    
                    //  [hud hide:YES];
                    
              //  }
                
                
               
            });
            
        
            
            
          }];
            
              });
        
        
        
    }*/
    
    
}



+(void) favoritePhotos:(NSArray*) arrayOfPHAsset  Result:(id<FileDeleteProtocol>) callback;
{

    PHAsset * asset;
    @try {
        for(asset in arrayOfPHAsset)
        {
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetChangeRequest *request = [PHAssetChangeRequest changeRequestForAsset:asset];
                
                if(asset.favorite)
                {
                    [request setFavorite:NO];
                }
                else{
                    [request setFavorite:YES];
                    
                }
            } completionHandler:^(BOOL success, NSError *error) {
                if (!success) {
                    //NSLog(@"Error: %@", error);
                }
            }];
        }
        [callback didFinishDeleting:YES];
    }
    @catch (NSException *exception) {
         [PhotoUtils handleException:exception];// do nothing
    }
    @finally {
        // do nothing
    }
    


 
    
    
    
}


+(void) deletePhotos:(NSArray*) arrayOfPHAsset  Result:(id<FileDeleteProtocol>) callback;
{
    @try {
        void (^completionHandler)(BOOL, NSError *) = ^(BOOL success, NSError *error) {
            if (success)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [callback didFinishDeleting:success];
                    
                });
            } else {
                
            }
        };
        
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest deleteAssets:arrayOfPHAsset];
        } completionHandler:completionHandler];
        
    }
    @catch (NSException *exception) {
        
          [PhotoUtils handleException:exception];// do nothing
    }
    @finally {
        // do nothing
    }
    
  
}




-(void) updateMbDeleted
{
    /*
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    float stored = [prefs floatForKey:@"mb"];
    
    float aggr;
    
    if(self.isCrush)
    {
        aggr = [_mbAggregate floatValue]/2;
        
    }
    else
    {
        aggr = [_mbAggregate floatValue];
        
    }
    
    
    float updateVal =  stored + aggr;
    [prefs setFloat:updateVal forKey:@"mb"];
    
    //reset to 0
    _mbAggregate=0;
     */
}


+(float) getMbDeleted
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    float deletedMB = [prefs floatForKey:@"mb"];
    return deletedMB;
    
}








+(void) photoSizeMonth:(int)year  Month:(int)month Result:(id<FileInfoProtocol>) callback ParentView:(UIView*)parentView;
{
    
    @try {
        NSDate* date = [NSDate firstDayOfMonth:year Month:month];
        NSDate*  date2 = [NSDate lastDayOfMonth:year Month: month];
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.predicate =    [NSPredicate
                                predicateWithFormat:@"(creationDate < %@) AND (creationDate > %@)",
                                date2, date ];
        
        
        
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [callback fileSizeWithId:[assetsFetchResults count]*1.3  ID:0];
        });
    }
    @catch (NSException *exception) {
        [PhotoUtils handleException:exception];// do nothing
    }
    @finally {
        // do nothing
    }
 

 
    
    /*
    PHAsset *asset;
    
    
   
    
  
 
          __block  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:parentView   animated:YES];
          hud.mode = MBProgressHUDModeIndeterminate;
          hud.labelText = NSLocalizedString(@"Calculating Space", @"running process to count the space on the hard drive"); 
          hud.color =  [UIColor colorWithRed:54.0f/255.0f
                                       green:205.0f/255.0f
                                        blue:253.0f/255.0f
                                       alpha:1];
    
     __block int hudCounter = [assetsFetchResults count];
    
    
    NSCalendar *cal = [[NSCalendar alloc] init];
    for(  asset in assetsFetchResults)
    {
      
       
        
        
        
        
        if(asset.mediaType== PHAssetMediaTypeImage)
        {
           
        }
        else if(asset.mediaType== PHAssetMediaTypeVideo)
        {
            
        }
        else{
            
             
        }
      
        
        NSDateComponents *components = [cal components:0 fromDate:asset.creationDate];
       
        
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            float imageSize = imageData.length;
           
               imageSize = imageSize/(1024*1024);
               
              imageSize = ceil(MAX(imageSize,1));
               
               
                dispatch_async(dispatch_get_main_queue(), ^{

            [callback fileSizeWithId:imageSize ID:[asset hash]];
               hudCounter--;
               if(hudCounter ==0)
               {
                   
                   [hud hide:YES];
                   
               }
            
             });
        }];
         
      });
        
    }
      
    */
 
}
 



@end
