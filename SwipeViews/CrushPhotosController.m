 //
//  CrushPhotosController.m
//  SwipeViews
//
//  Created by TouchROI on 12/30/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CrushPhotosController.h"
#import "ImageProcessing.h"
#import "UIImage+Resize.h"
#import "PHAsset+AssetUtil.h"
#import "CardView.h"


@import Photos;
@implementation CrushPhotosController

#pragma mark - initialization methods

- (instancetype)init
{
    self = [super initWithType:TotalMegabyte];
    if (self) {
        NSArray * bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TVSSwipePickControllerClean" owner:self options:nil];
        self.view = bundleArray[0];
    }
    return self;
}



#pragma mark - customizable methods
-(NSString*) rightLabelTitle
{

    return NSLocalizedString(@"Crush",@"reduce the size of the photos photos (verb)");
}

-(NSString*) leftLabelTitle
{
    return NSLocalizedString(@"Next",@"next photo photos (verb)");
    
}

-(void) process:(CardView*)card
{
    @try {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // [CrushPhotosController crushImage:card.asset];
            
        });
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception EXCeption Exception %@", exception.description);
    }
    @finally {
        // Do Nothing 
    }
  
    
}


+(void) crushImage:(PHAsset*) asset
{
    
    
    
    
    
    // PHFetchResult*  fetchResult = [PHAssetCollection fetchAssetCollectionsContainingAsset:asset withType:PHAssetCollectionTypeAlbum options:nil];
    
    
    
    
    
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
      
             /* this method alone will add the new item*/
             [asset setAssociatedObject:changeRequest.placeholderForCreatedAsset.localIdentifier];
             
 
             
         } completionHandler:^(BOOL success, NSError *error) {
             
 
             
         }];
   
     }];
    
    
    
    
    
 
    
    
    
}



@end
