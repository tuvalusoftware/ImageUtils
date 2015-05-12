//
//  ViewController.m
//  iCurate Crush
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CrushController.h"
#import "ImageProcessing.h"

#import  "CrushStartController.h"
#import  "CrushYearController.h"
#import  "CrushMonthController.h"
#import "CrushPhotosController.h"
#import "CrushControllerConfirm.h"
#import  "CrushControllerFinish.h"
#import  "GlobalManager.h"

@interface CrushController ()

@end

@implementation CrushController

#pragma mark - UIViewController Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _gManager = [GlobalManager  sharedInstance:FileOperationDelete View:self.view];
    [_gManager initializeView:self];
    _gManager.appId =@"951910993";
    [_gManager loadView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recommendAction:)
                                                 name:@"Recommend"  object:nil];
    
 
}

-(void) viewWillAppear:(BOOL)animated
{
    
    self.view.BackgroundColor = BASE_COLOR;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Controller Creation Methods
-(NSArray*) controllers
{
    
    _startController            =   [[CrushStartController alloc]  init];
    _yearController             =   [[CrushYearController alloc] init];
    _monthController            =   [[CrushMonthController alloc] init];
    _photosController           =   [[CrushPhotosController alloc] init];
    _confirmController          =   [[CrushControllerConfirm alloc] init];
    _finishController           =   [[CrushControllerFinish alloc] init];
    
    return  @[ _startController  , _yearController,_monthController,_photosController,_confirmController,_finishController];
    
}
 



/* create a new instance of the controller and replace it in in the controller list*/

-(NSArray*) createNewControllers:(UIViewController*) controller
{
    
    
    
    if(![controller isKindOfClass:CrushStartController.class])
    {
        _startController            =   [[CrushStartController alloc]  init];
    }
    if(![controller isKindOfClass:CrushYearController.class])
    {
        _yearController             =   [[CrushYearController alloc] init];
    }
    
    if(![controller isKindOfClass:CrushMonthController.class])
    {
         _monthController            =   [[CrushMonthController alloc] init];
    }
    
    if(![controller isKindOfClass:CrushPhotosController.class])
    {
        _photosController           =   [[CrushPhotosController alloc] init];
        
    }
    if(![controller isKindOfClass:CrushControllerConfirm.class])
    {
        _confirmController          =   [[CrushControllerConfirm alloc] init];
        
    }
    if(![controller isKindOfClass:CrushControllerFinish.class])
    {
       _finishController           =   [[CrushControllerFinish alloc] init];
        
    }
    
    
    return  @[ _startController  , _yearController,_monthController,_photosController,_confirmController,_finishController];
    

}
#pragma mark - SelectorProtocol Handler

 
-(void) handleFinish:(GlobalManager*) globalManager
{
    GlobalManager* gMansger = [GlobalManager sharedInstance];
  
    [PhotoUtils finishCrush:gMansger.leftSwipeAssets Result:self];
    
  
    
    
}

-(void) didFinishDeleting:(BOOL) success
{
    GlobalManager* gMansger = [GlobalManager sharedInstance];
    if([gMansger.leftSwipeAssets count]==0)
    {
        NSLog(@" shouldnt be here");
    }
    else
    {
        NSString * msg =nil;
        msg = [NSString stringWithFormat:@"Crushed %i files",[gMansger.leftSwipeAssets  count] ];
    
 
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:kStringMessageBarSuccessTitle
                                                   description:msg
                                                          type:TWMessageBarMessageTypeSuccess
                                                statusBarStyle:UIStatusBarStyleDefault
                                                      callback:nil];
        [gMansger.leftSwipeAssets   removeAllObjects];
    }
   
 
    
}


-(void) filesCrusshed
{
    GlobalManager* gMansger = [GlobalManager sharedInstance];
    [PhotoUtils deletePhotos:gMansger.leftSwipeAssets Result:self];
    
    
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
             
             
             [asset setAssociatedObject:changeRequest.placeholderForCreatedAsset.localIdentifier];
             
             
             //NSLog(@"local identifier %@", changeRequest.placeholderForCreatedAsset.localIdentifier);
             
             
         } completionHandler:^(BOOL success, NSError *error) {
             
             
             
             
         }];
         
         
         
         
         
     }];
    
    
    
    
    
    
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
    
    
    
}

#define mark - handle remcommend action

- (IBAction)recommendAction:(id)sender
{
    GlobalManager * gManager =  [GlobalManager sharedInstance];
 
     NSString * appStoreUrl  =[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8",gManager.appId];
    
    NSString *text = @"I Found this great app for favoriting my photos";
    NSURL *url = [NSURL URLWithString:appStoreUrl];
    UIImage *image = [UIImage imageNamed:@"screenshot.png"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url,image]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];

}

@end
