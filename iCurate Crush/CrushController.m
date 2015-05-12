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

#define mark - handle remcommend action

- (IBAction)recommendAction:(id)sender
{
    GlobalManager * gManager =  [GlobalManager sharedInstance];
 
     NSString * appStoreUrl  =[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8",gManager.appId];
    
    NSString *text = @"I Found this great app for compressing my photos and creating more space on my hard drive";
    NSURL *url = [NSURL URLWithString:appStoreUrl];
    UIImage *image = [UIImage imageNamed:@"screenshot.png"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url,image]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];

}



+(void) crushImage:(PHAsset*) asset
{
    
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
