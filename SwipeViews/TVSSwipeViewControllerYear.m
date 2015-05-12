//
//  TVSSwipeViewControllerYear.m
//  PhotoSelector
//
//  Created by TouchROI on 11/25/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSSwipeViewControllerYear.h"
#import "CardView.h"
#import "ZLSwipeableView.h"
#import "PhotoUtils.h"
#import "GlobalManager.h"




@interface TVSSwipeViewControllerYear () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
{
    int _currentYear;
    int _swipeCount;
}
@end

@implementation TVSSwipeViewControllerYear
{
    
    DataType _dataType;
    
}

#pragma mark - UIViewController methods

- (instancetype)initWithNibNameAndType:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil DataType:(DataType) dataType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataType = dataType;
    }
    return self;
}

- (instancetype)initWithType:(DataType) type
{
    self = [super init];
    if (self) {
          _dataType = type;
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _swipeCount=0;
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    self.swipeableView.dataSource = self;
    self.swipeableView.delegate = self;
    
    
    UIColor* color =BASE_COLOR;
    _swipeableView.backgroundColor = color;
    [self reload];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_leftBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    [_rightBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    [self reload];
}



#pragma mark - button methods
- (IBAction)leftBtnPressed:(id)sender {
    
     [self.swipeableView swipeTopViewToLeft];
}

- (IBAction)rightButtenPressed:(id)sender {
    
    
     [self.swipeableView swipeTopViewToRight];
}

- (IBAction)reload:(id)sender
{
    
    NSNotification *notification = [NSNotification notificationWithName:@"Repeat"  object:nil];
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostASAP];
}

- (IBAction)home:(id)sender
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"  object:nil];
    
}



#pragma mark- swipe left/right

- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view
{
    
    CardView *cView = (CardView*) view;
    
    CardView* card = (CardView*) view;
    [card.timer invalidate];
    card.timer = nil;
     [self manager].year  = [cView.year intValue];

    [NSTimer scheduledTimerWithTimeInterval: 0.3
                                     target: self
                                   selector:@selector(swipedLeftDelayed:)
                                   userInfo: nil repeats:NO];
     _swipeCount++;
    
}


-(void)swipedLeftDelayed:(NSTimer *)timer {
    
    NSNotification *notification = [NSNotification notificationWithName:@"Next"  object:nil];
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostASAP];
    
}

-(void) swipeRightDelayed: (NSTimer *)timer {
    
    NSNotification *notification = [NSNotification notificationWithName:@"Repeat"  object:nil];
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostASAP];
    
}



- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view
{

    CardView* card = (CardView*) view;
    [card.timer invalidate];
    card.timer = nil;
    CardView *cView = (CardView*) view;

    if(_swipeCount  == ((int) [self.arrayOfInteger count] -1))
    {
       [self manager].year = [cView.year intValue];
        [NSTimer scheduledTimerWithTimeInterval: 0.3
                                         target: self
                                       selector:@selector(swipeRightDelayed:)
                                       userInfo: nil repeats:NO];
    }
     _swipeCount++;
}



#pragma mark-unused swipe methods
- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location
{
    
    
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
    
  
}



- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    if (self.viewIndex< [self.arrayOfInteger count]) {
        
        NSNumber* number = [self.arrayOfInteger objectAtIndex:self.viewIndex];
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        view.tag=self.viewIndex;
        view.year = number;
        view.cardColor = [UIColor whiteColor];
        view.imageView.hidden = YES;
        [view showHint];
        
        if(_dataType == TotalMegabyte)
        {
             [view calculateYearMB:[number intValue] View:view];
        }
        else if(_dataType == CrushedMegabytes)
        {
            [view calculateYearMB:[number intValue] View:view];
        }
        else
        {
          int numFiles= [PhotoUtils numberOfPhotosInYear:[number intValue]];
          NSString * numFilesStringVal =   [NSString  stringWithFormat:@"%i Files",  numFiles];
          view.topLabel.text = numFilesStringVal;
        }
        
        NSString * stringVal =   [NSString  stringWithFormat:@"%i", [number intValue]];
        view.mainLabel.text = stringVal;
        view.cardText = stringVal;
        self.viewIndex++;
        return view;
    }
    return nil;
}

#pragma mark - utility methods

-(void) preloadYear
{
    int i;
    self.arrayOfInteger= [PhotoUtils getArrayOfYear:&i];
    self.currentYear=i;
}


-(void) reload
{
    [self preloadYear];
    self.viewIndex=0;
    _swipeCount =0;
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
    
}

#pragma mark - inherited methods

@end
