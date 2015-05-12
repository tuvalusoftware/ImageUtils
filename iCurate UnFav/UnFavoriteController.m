//
//  UnFavoriteController.m
//  SwipeViews
//
//  Created by TouchROI on 1/2/15.
//  Copyright (c) 2015 tim.obrien. All rights reserved.
//

#import "UnFavoriteController.h"
#import "GlobalManager.h"
#import "UnfavStart.h"
#import "UnfavPhotos.h"
#import "UnfavConfirm.h"
#import "UnfavFinish.h"
 
@interface UnFavoriteController ()

@end

@implementation UnFavoriteController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _gManager = [GlobalManager  sharedInstance:FileOperationDelete View:self.view];
    [_gManager initializeView:self];
    
    /* this is the unique app store id. Always check before uploading to store*/
    _gManager.appId =@"949220821";
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
    
    _unfavStart                 =   [[UnFavStart  alloc]  init];
    _unfavPhotos                =   [[UnfavPhotos alloc] init];
    _unfavConfirm               =   [[UnfavConfirm alloc] init];
    _unfavFinish                =    [[UnfavFinish alloc] init];
    
    return  @[ _unfavStart,_unfavPhotos,_unfavConfirm,_unfavFinish];
    
}
- (IBAction)permissions:(id)sender {
}

/* create a new instance of the controller and replace it in in the controller list*/

-(NSArray*) createNewControllers:(UIViewController*) controller
{
    
    /* this was originally the start dropdown */
    
    if(![controller isKindOfClass:UnFavStart.class])
    {
        
        _unfavStart                 =   [[UnFavStart  alloc]  init];
        
    }
    
    
    if(![controller isKindOfClass:UnfavPhotos.class])
    {
        _unfavPhotos                =   [[UnfavPhotos alloc] init];
    }
    
    if(![controller isKindOfClass:UnfavConfirm.class])
    {
        
        _unfavConfirm               =   [[UnfavConfirm alloc] init];
        
        
    }
    
    
    if(![controller isKindOfClass:UnfavFinish.class])
    {
        
        _unfavFinish                =    [[UnfavFinish alloc] init];
        
        
    }
    
    
    
    
    return  @[ _unfavStart,_unfavPhotos,_unfavConfirm,_unfavFinish];
    
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
    
    NSString *text = @"I found this awesome app to help me thin out my favorites elbum";
    NSURL *url = [NSURL URLWithString:appStoreUrl];
    UIImage *image = [UIImage imageNamed:@"screenshot_unlike.png"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[text, url,image]
     applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end
