//
//  ViewController.m
//  iCurate Favorite
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "FavoriteController.h"
#import "GlobalManager.h"


#import  "TVSStartFavorite.h"
#import  "FavoriteYearController.h"
#import  "FavoriteMonthController.h"
#import  "FavoritePhotos.h"
#import  "FavoriteConfirm.h"
#import  "GlobalManager.h" 
#import  "FavoriteFinish.h"

@interface FavoriteController ()

@end

@implementation FavoriteController

 




- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    _gManager = [GlobalManager  sharedInstance:FileOperationDelete View:self.view];
    [_gManager initializeView:self];
    _gManager.appId =@"952095032";
    [_gManager loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recommendAction:)
                                                 name:@"Recommend"  object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSArray*) controllers
{
    
        _favoriteStart              =   [[TVSStartFavorite alloc]  init];
        _favoriteYearController     =   [[FavoriteYearController alloc] init];
        _favoriteMonthController    =   [[FavoriteMonthController alloc] init];
        _favoritePhotos             =   [[FavoritePhotos alloc] init];
      
        _favoriteConfirm            =   [[FavoriteConfirm alloc] init];
        _favoriteFinish             =  [[FavoriteFinish alloc] init];
    
    return  @[ _favoriteStart  , _favoriteYearController,_favoriteMonthController,_favoritePhotos,_favoriteConfirm,_favoriteFinish];
    
}
- (IBAction)grantPermission:(UIButton *)sender {
}



/* create a new instance of the controller and replace it in in the controller list*/

-(NSArray*) createNewControllers:(UIViewController*) controller
{
    
 
    
    if(![controller isKindOfClass:TVSStartFavorite.class])
    {
         _favoriteStart          =   [[TVSStartFavorite alloc]  init];
    }
    if(![controller isKindOfClass:FavoriteYearController.class])
    {
         _favoriteYearController   =   [[FavoriteYearController alloc] init];
    }
    
    if(![controller isKindOfClass:FavoriteMonthController.class])
    {
        _favoriteMonthController    =   [[FavoriteMonthController alloc] init];
    }
    
    if(![controller isKindOfClass:FavoritePhotos.class])
    {
      _favoritePhotos             =   [[FavoritePhotos alloc] init];
      
    }
    if(![controller isKindOfClass:_favoriteConfirm.class])
    {
        _favoriteConfirm            =   [[FavoriteConfirm alloc] init];
        
    }
    if(![controller isKindOfClass:FavoriteFinish.class])
    {
        _favoriteFinish            =   [[FavoriteFinish alloc] init];
        
    }
    
    
    return  @[ _favoriteStart , _favoriteYearController,_favoriteMonthController,_favoritePhotos,_favoriteConfirm,_favoriteFinish];
}


#pragma mark - Favorite finish method
-(void) handleFinish:(GlobalManager*) globalManager
{
    GlobalManager* gMansger = [GlobalManager sharedInstance];
    
     [PhotoUtils favoritePhotos:gMansger.leftSwipeAssets Result:self];
    
    
    
}

#pragma mark - recommend action

- (IBAction)recommendAction:(id)sender
{
    GlobalManager * gManager =  [GlobalManager sharedInstance];
    
    NSString * appStoreUrl  =[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8",gManager.appId];
    
    NSString *text = @"I found this awesome app for favoriting my photos   that saved me lots of time";
    NSURL *url = [NSURL URLWithString:appStoreUrl];
    UIImage *image = [UIImage imageNamed:@"screenshot5.png"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url,image]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end
