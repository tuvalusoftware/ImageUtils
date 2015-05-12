//
//  TVSSwipeViewControllerMonthNumFiles.h
//  PhotoSelector
//
//  Created by TouchROI on 11/25/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSSwipeViewControllerMonthNumFiles.h"
#import "CardView.h"
#import "ZLSwipeableView.h"
#import "PhotoUtils.h"
#import "GlobalManager.h"

@interface TVSSwipeViewControllerMonthNumFiles () <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>
{
    
    int _currentMonth;
    int _swipeCount;
    
}
@end

@implementation TVSSwipeViewControllerMonthNumFiles

- (IBAction)home:(id)sender
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"Canceled"  object:nil];
    
}

- (IBAction)reload:(id)sender
{
    
    NSNotification *notification = [NSNotification notificationWithName:@"Repeat"  object:nil];
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostASAP];
    
    
}

- (IBAction)btnRightPressed:(id)sender
{
     [self.swipeableView swipeTopViewToRight];
}

- (IBAction)btnLeftPressed:(id)sender
{
     [self.swipeableView swipeTopViewToLeft];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.arrayOfMonth =[[NSArray  alloc] init];
    
    /* general strings */
    
    
    
    
    self.arrayOfString = @[
                    NSLocalizedString(@"January",@"month"),
                      NSLocalizedString(@"February",@"month") ,
                      NSLocalizedString(@"March",@"month") ,
                    NSLocalizedString(@"April",@"month"),
                     NSLocalizedString(@"May",@"month"),
                      NSLocalizedString(@"June",@"month"),
                     NSLocalizedString(@"July",@"month"),
                     NSLocalizedString(@"August",@"month"),
                    NSLocalizedString(@"September",@"month"),
                      NSLocalizedString(@"October",@"month"),
                     NSLocalizedString(@"November",@"month"),
                      NSLocalizedString(@"December",@"month")
                    ];
 
    
 
    
    _arrayOfMonth = [PhotoUtils arrayOfMonth:[self manager].year];
    
    //NSLog(@"%@", self.arrayOfMonth);
  
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
 
    self.swipeableView.dataSource = self;
    self.swipeableView.delegate = self;
    
    
    UIColor* color =[UIColor colorWithRed:54.0f/255.0f
                                    green:205.0f/255.0f
                                     blue:253.0f/255.0f
                                    alpha:1];
    
    
    
    
    _swipeableView.backgroundColor = color;
}
 

-(void) viewWillAppear:(BOOL)animated
{
    
    [self reload];
    
}

-(void) reload
{
    
    
    _arrayOfMonth = [PhotoUtils arrayOfMonth:[self manager].year];
    self.colorIndex=0;
    _swipeCount =0;
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
    
}



- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view
{
    CardView* card = (CardView*) view;
    [card.timer invalidate];
    card.timer = nil;
    
    _swipeCount++;
    CardView *cView = (CardView*) view;
    
  
    [self manager].month = [cView.month intValue];
    
    
    [NSTimer scheduledTimerWithTimeInterval: 0.3
                                     target: self
                                   selector:@selector(onTick:)
                                   userInfo: nil repeats:NO];

    
    
    
    
}

-(void)onTick:(NSTimer *)timer {
    
    NSNotification *notification = [NSNotification notificationWithName:@"Next"  object:nil];
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostASAP];
    
}



-(void)onTickAgain:(NSTimer *)timer {
    
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
    
    
    
 
   
    if(_swipeCount == ((int)  [self.arrayOfMonth count]-1) )
    {
        [self manager].month = [cView.month intValue];
        [NSTimer scheduledTimerWithTimeInterval: 0.3
                                         target: self
                                       selector:@selector(onTickAgain:)
                                       userInfo: nil repeats:NO];
    }
    
    
    //NSLog(@" the count %i", _swipeCount );
 
       _swipeCount++;
}




- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
    
 
    
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}



////////



////////////////
#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
 
    
    if (self.colorIndex< [self.arrayOfMonth count]) {
        
        
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        
        NSArray * copy = [[self.arrayOfMonth  reverseObjectEnumerator] allObjects];
        
        NSNumber * numbr = [copy objectAtIndex:self.colorIndex ];
       
        int month =  [numbr intValue];
        int year  =  [self manager].year;
        NSString* stringVal;
        int numFiles= [PhotoUtils numberOfPhotosInMonth:year Month:month];
        NSString * numFilesStringVal =   [NSString  stringWithFormat:@"%i Files",  numFiles];
        view.topLabel.text = numFilesStringVal;
        stringVal =   [NSString  stringWithFormat:@"%i", year];
        view.month = [NSNumber numberWithInt:month];
        view.cardColor = [UIColor whiteColor];
        view.imageView.hidden = YES;
        view.mainLabel.text = [self.arrayOfString  objectAtIndex:month-1];
        view.cardText = [self.arrayOfString  objectAtIndex:month-1];
        [view showHint];
        [view setNeedsDisplay];
        
        self.colorIndex++;
        return view;
    }
    return nil;
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
