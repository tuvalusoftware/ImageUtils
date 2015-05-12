//
//  ViewController.m
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSSwipPickControllerClean.h"
#import "NSDate+Calc.h"
#import "ZLSwipeableView.h"
#import "CardView.h"
#import "GridViewController.h"
#import "PhotoUtils.h"
#import "GlobalManager.h"
#import "Configs.h"

@import Photos;

@interface TVSSwipePickControllerClean () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (strong) PHCachingImageManager *imageManager;
@property (nonatomic, strong) NSArray *colors;
@property (strong) NSMutableArray* leftSwipeAssets;
@property (strong) NSMutableArray* rightSwipeAssets;
@property (strong) PHAsset *currentAsset;

@end

 
@implementation TVSSwipePickControllerClean
{
    int  _swipeCount;
    float _mbAggregate;
    float _imageSize;
    DataType _dataType;
        
 
}


#pragma initialiation methods

- (instancetype)initWithType:(DataType) type
{
    self = [super init];
    if (self) {
        _dataType = type;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
         _dataType = TotalMegabyte;
        
    }
    
    return self;
}

- (void)awakeFromNib
{

    
    _assetsFetchResults = [self fetchAssets];
    
    
}


- (void)resetCachedAssets
{
    [self.imageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
    
}



-(void)  reload
{
    self.viewIndex=0;
    _swipeCount =0;
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
    [self awakeFromNib];
    
}


#pragma mark - button methods
- (IBAction)swipeLeft:(id)sender {
    [self.swipeableView swipeTopViewToLeft];
}

- (IBAction)swipeRight:(id)sender {
    [self.swipeableView swipeTopViewToRight];
}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"    object:nil];
    
}

- (IBAction)home:(id)sender
{
    [_leftSwipeAssets removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"  object:nil];
    
}





- (IBAction)finish:(id)sender
{
      //if(_deletedArray)
       //   [_leftSwipeAssets   removeObjectsInArray:_deletedArray];

        self.manager.leftSwipeAssets = _leftSwipeAssets;
        self.manager.rightSwipeAssets = _rightSwipeAssets;
    
    if([_leftSwipeAssets count] ==0)
    {
    
     
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Notice"
                                                         message:  NSLocalizedString(@"No Files ",@"files not selected")
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
   
        [alert show];

    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Next"  object:nil];
        
    }
    
    
}


- (IBAction)reloadView:(id)sender
{
    if(!_gridView || !_navController)
    {
        
        _gridView = [[GridViewController alloc] initWithNibNameAndSelect:@"GridViewController" bundle:nil Select:NO];
        _gridView.isReview=NO;
        
        
        _navController = [[UINavigationController alloc] initWithRootViewController:_gridView];
    }
    [self.view addSubview:_navController.view];
    
    
    NSMutableSet* set = [[NSMutableSet alloc] initWithArray:self.manager.assetRemoveArray];
    [_gridView initWithArray:_leftSwipeAssets RemoveSet:set];
    
    
    
    
}

#pragma mark - view controller methods


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [_leftButton setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    [_rightButton setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    
    
   [self awakeFromNib];

   if(self.operationType==0)
   {
 
      [_rightButton setTitle:self.rightLabelTitle forState:UIControlStateNormal];
      [_leftButton setTitle:self.leftLabelTitle forState:UIControlStateNormal];
   }
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reviewDone:)
                                                 name:@"AssetReviewDone"  object:nil];
 
    
    
    _mbAggregate =0;
    _imageSize=0;
    
}


- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    
    [self awakeFromNib];
    
    self.swipeableView.escapeVelocityThreshold = 2000;
    _leftSwipeAssets =  [NSMutableArray new];
    _rightSwipeAssets = [NSMutableArray new];
    
    self.imageManager = [[PHCachingImageManager alloc] init];
    [self resetCachedAssets];
    
    
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
    // required data source
    self.swipeableView.dataSource = self;
    
    self.swipeableView.delegate = self;
    
    
    self.swipeableView.delegate = self;
    
    UIColor* color =BASE_COLOR;
    
     _swipeableView.backgroundColor = color;
    
    
 
    
 
}
-(void) viewWillDisappear:(BOOL)animated
{
      [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
}





-(IBAction)reviewDone:(NSNotification*)notification
{
       NSDictionary * dict = notification.userInfo;
       NSMutableSet * set = (NSMutableSet* ) [dict objectForKey:@"remoeArray"];
    
       _deletedArray = [[NSArray alloc] initWithArray:[set allObjects]];
       _mbAggregate = [self.manager.mbAggregate floatValue];
       BOOL hasAsset = ([set count] >0);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
 
       
    PHAsset *asset;
    for(asset in set)
    {
        if(_dataType==TotalMegabyte)
        {
        
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                float imageSize = imageData.length;
            
                imageSize = imageSize/(1024*1024);
                _mbAggregate -= imageSize ;
                NSString *  formatedNumber=[self formatNumber:_mbAggregate];
            
                dispatch_async(dispatch_get_main_queue(), ^{
                self.mbSelected.text  =formatedNumber;
                
                });
            
            
        }];
        }
        
 
        
    }
                 
    });
    
    
    if(!hasAsset)
    {
       
        if(_dataType==TotalMegabyte)
        {
            NSString *  formatedNumber=[self formatNumber:[self.manager.mbAggregate floatValue]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.mbSelected.text  =formatedNumber;
            
            });
        }
        
    }
}




#pragma mark - swipable views left/right
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view
{
    
    CardView* card = (CardView*) view;
    card.isSwiped = YES;
    [card.timer invalidate];
    card.timer = nil;
    
    CardView *cView = (CardView*) view;
    [_leftSwipeAssets addObject:cView.asset];
    
  /* if we are calculating total bytes used */
  if(_dataType==TotalMegabyte)
  {
    _mbAggregate += card.tempValue  ;
    self.manager.mbAggregate = [NSNumber numberWithFloat:_mbAggregate];
    
    NSString *  formatedNumber=[self formatNumber:_mbAggregate];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mbSelected.text  =formatedNumber;
        
    });
  }
 else
 {
        self.mbSelected.text  =@"";
     
 }
    
 
   
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             [self process:card];
       });
   
    
 
    
   
  

   _swipeCount++;
    
    [_rightButton   setTitle:self.rightLabelTitle  forState:UIControlStateNormal];
    [_leftButton    setTitle:self.leftLabelTitle   forState:UIControlStateNormal];
    
    if(_swipeCount == [_assetsFetchResults count])
    {

        [self finish:nil];
        
        
    }
 
  
 
    
}


- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view
{
    
    
    CardView* card = (CardView*) view;
    card.isSwiped = YES;
    [card.timer invalidate];
    card.timer = nil;
    

    
    CardView *cView = (CardView*) view;
    [_rightSwipeAssets addObject:cView.asset];
    
    _swipeCount++;
    [_rightButton setTitle:self.rightLabelTitle forState:UIControlStateNormal];
    [_leftButton setTitle:self.leftLabelTitle forState:UIControlStateNormal];
    
    if(_swipeCount== [_assetsFetchResults count]  )
    {

        [self finish:nil];
       
    }
    else
    {

        
    }
   
    

    
}





- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
    
 
    
}


- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
    
    
   
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    if (self.viewIndex< [_assetsFetchResults count] ) {
        
        
    
        
        __block CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
       
        
        [view showThumbImages];
        PHAsset *asset = _assetsFetchResults[_viewIndex];
        
    
        
        if( _dataType ==TotalMegabyte)
        {
            
             [view getaTrueFileSize:asset];
            
        }
        if( _dataType ==NumberOfPhotos)
        {
            
             view.topLabel.hidden = YES;
            
        }
           [_leftButton setTitle:self.leftLabelTitle forState:UIControlStateNormal];
        
        if(self.operationType ==0)
        {
        
        [_rightButton setTitle:self.rightLabelTitle forState:UIControlStateNormal];
     
        }
        else
        {
            
            
          
            if(asset.favorite)
            {
                
                 [_rightButton setTitle:NSLocalizedString(@"Un-Favorite",@"unforite photos (verb)") forState:UIControlStateNormal];
                
             ;
                
            }
            else
            {
                  [_rightButton setTitle:NSLocalizedString(@"Favorite",@"favorite photos (verb)") forState:UIControlStateNormal];
                
                
                
            }
            
            
            
        }
 
        view.asset = asset;
        [self.imageManager requestImageForAsset:asset
                                     targetSize:CGSizeMake(400, 400)
                                    contentMode:PHImageContentModeAspectFill
                                        options:nil
                                       resultHandler:^(UIImage *result, NSDictionary *info) {
                                           
                                       view.imageView.image = result;
                                           
                                        
                                      
                                  }];
             
        
        
        self.viewIndex++;
        [view  bringSubviewToFront:view.topLabel];
        view.cardColor = [UIColor whiteColor];
        
        
      
 
         return view;
    }
    return nil;
}

- (IBAction)Done:(id)sender
{
    self.manager.leftSwipeAssets = _leftSwipeAssets;
    self.manager.rightSwipeAssets = _rightSwipeAssets;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Next"  object:nil];
    
    
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(int) operationType
{
    return 0;
}


#pragma mark - customization methods

-(NSString*) rightLabelTitle
{
    return @"Delete";
}

-(NSString*) leftLabelTitle
{
    return @"Keep";
    
}

-(PHFetchResult*) fetchAssets
{
    NSDate* date =
    [NSDate firstDayOfMonth: [self manager].year Month: [self  manager].month];
    NSDate*  date2 =
    [NSDate lastDayOfMonth: [self manager].year Month: [self manager].month];
    
    
      return [PhotoUtils getPhotosBetweenDates:date2  endDate:date];
}

-(void) process:(CardView*)  card
{
    
   // do nothing
    
}


@end
