//
//  GridViewController.m
//  PhotoSelector
//
//  Created by TouchROI on 11/24/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "GridViewController.h"
#import "AAPLAssetGridViewController.h"
#import "GlobalManager.h"

@interface GridViewController ()

@end




@implementation GridViewController



-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Select:(BOOL) isNotSelect {
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        _gridController = [sb instantiateViewControllerWithIdentifier:@"AssetGrid"];
        
        _gridController.isNotSelect =NO;;
        
    }
    return self;
}

-(instancetype)initWithNibNameAndSelect:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Select:(BOOL) isNotSelect {
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
      UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
      _gridController = [sb instantiateViewControllerWithIdentifier:@"AssetGrid"];
        
        _gridController.isNotSelect =isNotSelect;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
  
 
 
    CGRect rect = self.view.frame;
    _gridController.view.frame = CGRectMake(0, 70, rect.size.width, rect.size.height-70);
    [self.view   addSubview:_gridController.view];
    
  _doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done",nil)style:UIBarButtonItemStyleDone
                                                                 target:self action:@selector(done:)];
    
    [_doneBtn setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
     [UIColor blackColor], NSForegroundColorAttributeName,nil]
    forState:UIControlStateNormal];
    
    
 
    self.navigationItem.rightBarButtonItem = _doneBtn;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
   UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = BASE_COLOR;
    
    
    self.navigationController.navigationBar.backgroundColor = BASE_COLOR;
    _gridController.collectionView.backgroundView = blueView;
    
    
   
    
}


-(void) initWithArray:(NSMutableArray*) array RemoveSet:(NSMutableSet*) set
{
    
    _assetsForDelete = set;
    _gridController.assetArray=[array copy];
    _gridController.assetRemoveArray = set;
    
    [_gridController.collectionView reloadData];
    
}

-(IBAction)done:(id)sender
{
    
    
   
    GlobalManager* manager =[GlobalManager sharedInstance];
    
    manager.assetRemoveArray= [[NSMutableArray alloc] initWithArray:[_gridController.assetRemoveArray allObjects]];
    
    
 
    
    
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          _gridController.assetRemoveArray, @"remoeArray",
                         
                          nil];

    
    
    
    if(_isReview)
    {
        NSNotification *notification =
        [NSNotification notificationWithName:@"AssetReviewDone2"  object:self userInfo:dict];
        [[NSNotificationQueue defaultQueue]
         enqueueNotification:notification
         postingStyle:NSPostNow];
    
    }
    else
    {
        
        NSNotification *notification =
               [NSNotification notificationWithName:@"AssetReviewDone"  object:self userInfo:dict];
        [[NSNotificationQueue defaultQueue]
         enqueueNotification:notification
         postingStyle:NSPostNow];
        
        
    }
    [self.navigationController.view removeFromSuperview];
    
}

- (IBAction)confirm:(id)sender
{
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
 
 
    [_gridController.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
