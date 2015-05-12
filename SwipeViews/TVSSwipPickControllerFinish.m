//
//  ViewController.m
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSSwipPickControllerFinish.h"
#import "NSDate+Calc.h"
#import "ZLSwipeableView.h"
#import "CardView.h"
#import "AppDelegate.h"
#import "GridViewController.h"
#import "PhotoUtils.h"
#import "GlobalManager.h"
#import <Social/Social.h>
#import "Configs.h"



@import Photos;

@interface TVSSwipPickControllerFinish() <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>







@end


@implementation TVSSwipPickControllerFinish
{
    
    DataType _dataType;
    
}

#pragma mark -initialization methods


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


#pragma mark - left/right swipe
 
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view
{
   [self recommend];
    
}

- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"  object:nil];
    
}





#pragma mark - rating/ recommending logic
-(void) recommend
{
   if(![self didRate])
   {
       
      NSString * appStoreUrl  =[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8",self.manager.appId];
       
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
       [self updateDidRate];
       
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"   object:nil];
   }
   else{
       
       
           
       
       
       [[NSNotificationCenter defaultCenter] postNotificationName:@"Recommend"   object:nil];
       
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"   object:nil];
       
   }
    
    
    
    
}





-(void) updateDidRate
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:YES forKey:@"didRate"];
 
}


-(BOOL) didRate
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    BOOL  didRate = [prefs boolForKey:@"didRate"];
    return didRate;
    
}


#pragma mark - protocol methds
-(void) didFinishDeleting:(BOOL) success{};



 


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
    
    self.swipeableView.dataSource = self;
    self.swipeableView.delegate = self;
    
    UIColor* color =BASE_COLOR;
    
    
    _swipeableView.backgroundColor = color;
    
 
        
    if(![self didRate])
    {
             [_btnLeft setTitle: NSLocalizedString(@"Rate Us",@"button take user to app store where he/she rates the app")   forState:UIControlStateNormal];
    }
    else
    {
             [_btnLeft setTitle: NSLocalizedString(@"Recommend",@"button launches social sharing dialog to share on Facebook, Twitter, messaging.... ")   forState:UIControlStateNormal];
            
    }
        
        
    [_btnRight setTitle:NSLocalizedString(@"Done",@"job completed return to home ")  forState:UIControlStateNormal];
        
        
        
    
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aggregateUpdate:)
                                                 name:@"UpdatedAggregate"  object:nil];
    
  
    
 
   
   
 
 
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
        _cardView.mainLabel.text = self.mainLabel;
        
    });
}


#pragma mark - button pressed mothod
- (IBAction)btnPressedLeft:(id)sender {
    
     [self.swipeableView swipeTopViewToLeft];
    
}


- (IBAction)btnPressedRight:(id)sender {
    
     [self.swipeableView swipeTopViewToRight];
    
    
}



#pragma mark - unused swipe mthods didStartSwipingView,swipeableView,didEndSwipingView

- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
   
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}




-(IBAction)updateDeleted:(NSNotification* ) notification
{
    
   // updateForDeletedFile
    
    
}



#pragma mark -  create views
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    
    
    
 
     CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    
       [view showImagesRate];
       view.topLabel.hidden = YES;
       [view.mainLabel setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:30]];
       [view.topLabel setHighlighted:YES];
       view.rateUsLabel.hidden = NO;
        
        
        if([self didRate])
        {
            
            
            view.rateUsLabel.text = @"Recommend Us";
            
            
        }
        
        
  
     //we only want to return one card
      if(!_isStarted)
      {
        _isStarted=YES;
      
        view.topLabel.text =  [self formatNumber:[self.manager.mbAggregate floatValue]];
        view.cardColor = [UIColor whiteColor];
        view.imageView.hidden = YES;
        view.mainLabel.text = self.mainLabel;
        _cardView = view;
        return view;
      }
    
    
    
    return nil;
}


#pragma  mark - misc util methods formatNumber...

-(NSString*) formatNumber:(float) size
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:size]];
    NSString * resStr = [NSString stringWithFormat:@"%@",numberString];
    
    return resStr;
}

#pragma mark - inheritable methods

-(NSString*) mainLabel
{
    float total =[self.manager.mbAggregate floatValue];
    float deleted = [self.manager.mbAggregateDeleted floatValue];
    float newAggregate =(total-deleted);
    NSString * str = [self formatNumber:newAggregate ];
    NSString *label = [NSString   localizedStringWithFormat:NSLocalizedString(@"%@ MB Deleted!",nil),str];
    return label;
    
}





@end
