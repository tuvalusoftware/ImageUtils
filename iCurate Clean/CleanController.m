//
//  ViewController.m
//  iCurate Clean
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "CleanController.h"
#import "GlobalManager.h"


#import "TVSStartWithDropdown.h"
#import "TVSSwipeViewControllerYear.h"
#import "TVSSwipeViewControllerMonth.h"
#import "TVSSwipPickControllerClean.h"
#import "TVSSwipPickControllerConfirm.h"
#import "TVSSwipPickControllerFinish.h"
#import "PhotoUtils.h"
#import "TWMesssageBarDemoController.h"
#import "Configs.h"
@interface CleanController ()

@end

@implementation CleanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   _gManager = [GlobalManager  sharedInstance:FileOperationDelete View:self.view];
    [_gManager initializeView:self];
    
    
   // _gManager.appId =@"948446366";
    _gManager.appId =@"948446366";
    [_gManager loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recommendAction:)
                                                 name:@"Recommend"  object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reviewDone:)
                                                 name:@"AssetReviewDone2"  object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSArray*) controllers
{
    
    _startDropdownController      =   [[TVSStartWithDropdown alloc]  initWithNibName:@"TVSStartWithDropdown" bundle:nil ];
    
    
    _yearController = [[TVSSwipeViewControllerYear alloc] initWithNibNameAndType:@"TVSSwipePickControllerYear" bundle:nil DataType:TotalMegabyte];
    
    
    _monthController = [[TVSSwipeViewControllerMonth alloc] initWithNibNameAndType:@"TVSSwipePickControllerMonth" bundle:nil  DataType:TotalMegabyte];
    
    _photoCleanController= [[TVSSwipePickControllerClean alloc] initWithNibName:@"TVSSwipePickControllerClean" bundle:nil];
    
    
    
    
    _confirmController = [[TVSSwipPickControllerConfirm alloc] initWithNibName:@"TVSSwipePickControllerConfirm"  bundle:nil];
    
    
    _finishController = [[TVSSwipPickControllerFinish alloc] initWithNibName:@"TVSSwipePickControllerFinish" bundle:nil];
      
   
   return  @[ _startDropdownController  , _yearController, _monthController,_photoCleanController,_confirmController,_finishController];
   
}
- (IBAction)checkPermisisons:(id)sender {
}

/* create a new instance of the controller and replace it in in the controller list*/

-(NSArray*) createNewControllers:(UIViewController*) controller
{
    
    /* this was originally the start dropdown */
    
    if(![controller isKindOfClass:TVSStartWithDropdown.class])
    {
        
        _startDropdownController      =   [[TVSStartWithDropdown alloc]  initWithNibName:@"TVSStartWithDropdown" bundle:nil];
        
    }
    
    
    if(![controller isKindOfClass:TVSSwipePickControllerClean.class])
    {
        _photoCleanController= [[TVSSwipePickControllerClean alloc] initWithNibName:@"TVSSwipePickControllerClean" bundle:nil];
    }
    
    if(![controller isKindOfClass:TVSSwipeViewControllerYear.class])
    {
        
        _yearController = [[TVSSwipeViewControllerYear alloc] initWithNibNameAndType:@"TVSSwipePickControllerYear" bundle:nil DataType:TotalMegabyte];
        
        
    }
    
    
    if(![controller isKindOfClass:TVSSwipeViewControllerMonth.class])
    {
        
        _monthController = [[TVSSwipeViewControllerMonth alloc] initWithNibNameAndType:@"TVSSwipePickControllerMonth" bundle:nil DataType:TotalMegabyte];
        
        
    }
    
    if(![controller isKindOfClass:TVSSwipPickControllerConfirm.class])
    {
        
        _confirmController = [[TVSSwipPickControllerConfirm alloc] initWithNibNameAndType:@"TVSSwipePickControllerConfirm"  bundle:nil Type:TotalMegabyte];
    }
    
    if(![controller isKindOfClass:TVSSwipPickControllerFinish.class])
    {
        
      
        _finishController = [[TVSSwipPickControllerFinish alloc] initWithNibNameAndType:@"TVSSwipePickControllerConfirm"  bundle:nil Type:TotalMegabyte];
    }
    
    
    
    return  @[ _startDropdownController , _yearController, _monthController,_photoCleanController,_confirmController,_finishController ];
    
    
}


#pragma mark - scrub finish method
-(void) handleFinish:(GlobalManager*) globalManager
{
    GlobalManager* gMansger = [GlobalManager sharedInstance];
    
   
    [PhotoUtils deletePhotos:gMansger.leftSwipeAssets Result:self];
    
    
    
}

-(void) didFinishDeleting:(BOOL) success
{
  
    
    NSString * msg =nil;
   GlobalManager* gMansger = [GlobalManager sharedInstance];
   
        msg = [NSString stringWithFormat:@"Deleted %i files",[gMansger.leftSwipeAssets  count] ];
 
    
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:kStringMessageBarSuccessTitle
                                                   description:msg
                                                          type:TWMessageBarMessageTypeSuccess
                                                statusBarStyle:UIStatusBarStyleDefault
                                                      callback:nil];
    
    
    [gMansger.leftSwipeAssets   removeAllObjects];
    
    
  
    
}

#pragma mark -- handled grid control lose






#pragma mark - recommend action handler
#define mark - handle remcommend action

- (IBAction)recommendAction:(id)sender
{
    GlobalManager * gManager =  [GlobalManager sharedInstance];
    
    NSString * appStoreUrl  =[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8",gManager.appId];
    
    NSString *text = @"I found this awesome app for removing photos from my photo roll that saved me tons of  space";
    NSURL *url = [NSURL URLWithString:appStoreUrl];
    UIImage *image = [UIImage imageNamed:@"screenshot3.png"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url,image]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}


#pragma mark - Grid Controller
-(IBAction)reviewDone:(NSNotification*)notification
{
    NSDictionary * dict = notification.userInfo;
    
    NSMutableSet * array = (NSMutableSet* ) [dict objectForKey:@"remoeArray"];
    
    GlobalManager * gManager =  [GlobalManager sharedInstance];
    gManager.mbAggregateDeleted =0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        
        
        
          gManager.numberFilesExcluded = (int) [array count];
        
        
    
        if([array count] ==0)
        {
            gManager.mbAggregateDeleted =0;
            gManager.numberFilesExcluded = 0;
            NSNotification *notification =
            [NSNotification notificationWithName:@"UpdatedAggregate"  object:self userInfo:dict];
            [[NSNotificationQueue defaultQueue]
             enqueueNotification:notification
             postingStyle:NSPostNow];
            
            //nothing changed so we don't need to update
            /*
             
             so what if the user adds a file back. I guess in this case this we shoud get the total updated files. 
             
             the logic in the handler should be if mbAggregateDeleted == 0 then display the mbAggrigated.
             
             
             */
            return;
            
        }
        
        PHAsset *asset;
        __block int count=0;
        
        
        
        
        
        for(asset in array)
        {
            
            
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                float imageSize = imageData.length;
                
                imageSize = imageSize/(1024*1024);
                float tm=  [gManager.mbAggregateDeleted floatValue];
                
                float newval = imageSize+tm ;
                
                gManager.mbAggregateDeleted =[NSNumber numberWithFloat:newval];
                
                count++;
                if(count ==[array count])
                {
                    NSNotification *notification =
                    [NSNotification notificationWithName:@"UpdatedAggregate"  object:self userInfo:dict];
                    [[NSNotificationQueue defaultQueue]
                     enqueueNotification:notification
                     postingStyle:NSPostNow];
                    
                    
                }
                
            }];
            
            
            
        }
        
        
        
    });
    
    
}

 

@end
