//
//  ViewController.m
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSSwipPickControllerConfirm.h"
#import "NSDate+Calc.h"
#import "ZLSwipeableView.h"
#import "CardView.h"
#import "AppDelegate.h"
#import "GridViewController.h"
#import "PhotoUtils.h"
#import "GlobalManager.h"
#import <Social/Social.h>


@import Photos;

@interface TVSSwipPickControllerConfirm() <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>


@end




@implementation TVSSwipPickControllerConfirm
{
    
    DataType _dataType;
    
}

#pragma mark - initialization methods 


- (instancetype)initWithType:(DataType) type
{
    self = [super init];
    if (self) {
        _dataType = type;
    }
    return self;
}


-(instancetype) initWithNibNameAndType:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  Type:(DataType) theType
{
   
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        
         _dataType =theType;
        
    }
    
    return self;
    
}


#pragma mark - unused protocol methods

-(void) didFinishFavoriting:(BOOL)success
{
    
    
}



-(void) didFinishDeleting:(BOOL)success
{
    
    
}

#pragma mark - swipe methods
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"   object:nil];
    
}


- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view
{
 
    
        NSString * msg;
        
        if(_noFilesSelected)
        {
            msg =@"Canceled";
            
        }
        else
        {
            if( ![_deleteArray count] ==0 )
            {
               [self.manager.leftSwipeAssets  removeObjectsInArray:_deleteArray];
            }
            
              [self.manager  handleFinish];
        
             msg =@"Next";
        }
    
       
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:msg  object:nil];
        
   
    
}




#pragma mark - methods of UIViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
    
    self.swipeableView.dataSource = self;
    self.swipeableView.delegate = self;
    
    UIColor* color =BASE_COLOR;
    
    
    
    
    _swipeableView.backgroundColor = color;
    
     [_btnLeft setTitle:[self leftBtnTitle] forState:UIControlStateNormal];
     [_btnRight setTitle:[self rightBtnTitle] forState:UIControlStateNormal];
  ;
    

    
    
   }


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_btnLeft setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    [_btnRight setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    
    
    
   /* if we are interested in the total megabytes register here*/
   if(TotalMegabyte ==_dataType)
   {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aggregateUpdate:)
                                                 name:@"UpdatedAggregate"  object:nil];

    
   }
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
       [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - notification handler

-(IBAction)aggregateUpdate:(NSNotification*)notifcation
{
     self.cardView.topLabel.hidden=NO;
    
    NSDictionary * dict = notifcation.userInfo;
    NSMutableSet * set = (NSMutableSet* ) [dict objectForKey:@"remoeArray"];
    NSArray* array = [set allObjects];
   
    self.deleteArray = [[NSMutableArray alloc] initWithArray:array];
      dispatch_async(dispatch_get_main_queue(), ^{
          
          float total =[self.manager.mbAggregate floatValue];
          float deleted = [self.manager.mbAggregateDeleted floatValue];
          float newAggregate =(total-deleted);
          NSString * str = [self formatNumber:newAggregate];
          _cardView.topLabel.text =   str;
          _cardView.mainLabel.text = self.theText;
 
      });
}





#pragma mark - button mothods
- (IBAction)btnPressedLeft:(id)sender {
    
     [self.swipeableView swipeTopViewToLeft];
    
}


- (IBAction)btnPressedRight:(id)sender {
    
     [self.swipeableView swipeTopViewToRight];
    
    
}

-(IBAction)showDetailsView:(id)sender
{
    
    _gridView = [[GridViewController alloc] initWithNibNameAndSelect:@"GridViewController" bundle:nil Select:self.isNotSelect];
    _gridView.isReview=YES;
     
    
    
    NSMutableSet* set = [[NSMutableSet alloc] initWithArray:self.manager.assetRemoveArray];
    [_gridView initWithArray:self.manager.leftSwipeAssets RemoveSet:set];
    _navController = [[UINavigationController alloc] initWithRootViewController:_gridView];
    [self.view addSubview:_navController.view];
    
    
    
}

-(IBAction) reviewDone:(id) object
{
    
    _cardView.mainLabel.text = [self theText];
    _cardView.topLabel.text=@"";
    
    [self aggregateUpdate:object];
}


#pragma mark - unused swipe methods
- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
   
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}





#pragma mark - next view
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    
    NSString* labelText;
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    
  
 
        
        
       // _myLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y- rect.size.height-3 , rect.size.width, rect.size.height)];
       // _myLabel.text = @"hello";
        [view addSubview:_myLabel];
 
       
       int count =  (int) ([self.manager.leftSwipeAssets count]-[self.manager.assetRemoveArray count])  ;
        
        //labelText = NSString   @"Delete Files";
        
        if(count > 0)
        {
 
            
         
        }
        else
        {
            _noFilesSelected=YES;
            
            [view showHintGreen];
            view.topLabel.hidden=YES;
            
        }
        
    
         view.topLabel.hidden=NO;
        
       
        view.reviewBtn.hidden = NO;
        [view.reviewBtn  addTarget:self action:@selector(showDetailsView:) forControlEvents:UIControlEventTouchUpInside];
        
  
    
      if(!_isStarted)
      {
          
        _isStarted=YES;
          
          int count =  (int) ([self.manager.leftSwipeAssets count]-[self.manager.assetRemoveArray count])  ;
          
          
          
       if(TotalMegabyte ==_dataType)
       {
           if(count >0)
           {
               view.topLabel.text =  [self formatNumber:[self.manager.mbAggregate floatValue]];
           }
           else
           {
               
                view.topLabel.text=@"0.0 MB";
               
           }
       }
        view.cardColor = [UIColor whiteColor];
        view.imageView.hidden = YES;
        view.mainLabel.text = [self theText];
        _cardView = view;
        return view;
      }
 
    return nil;
}



#pragma mark- misc methods formatNumber...
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
#pragma mark - extended methods

-(NSString*) rightBtnTitle
{
    return NSLocalizedString(@"Cancel",@"canncel all operations return to home screen");;
    
}

-(NSString*) leftBtnTitle
{
    
        return NSLocalizedString(@"Delete All",@"remove all files from ios hardrive")  ;
    
}

-(NSString*) theText
{
          int count =  (int) ([self.manager.leftSwipeAssets count]-[self.manager.assetRemoveArray count])  ;
    
    if(count >0)
    {
         return [NSString localizedStringWithFormat:NSLocalizedString(@"delete %i files?",nil) , count];
    }
    else{
         return NSLocalizedString(@"No Files Selected",nil);
        
    }
}

-(BOOL) isNotSelect
{
    return NO;
    
}

@end
