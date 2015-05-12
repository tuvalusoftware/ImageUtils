//
//  ViewController.m
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSSwipPickControllerStart.h"
#import "NSDate+Calc.h"
#import "ZLSwipeableView.h"
#import "CardView.h"
#import "Configs.h"



@import Photos;

@interface TVSSwipPickControllerStart() <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@end


@implementation TVSSwipPickControllerStart

// reload protocol
-(void) reload
{
    
    
    
}


 
- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeLeft:(UIView *)view
{
  
    CardView* card = (CardView*) view;
    [card.timer invalidate];
     card.timer = nil;
    
    
    [NSTimer scheduledTimerWithTimeInterval: 0.3
                                     target: self
                                   selector:@selector(onTick:)
                                   userInfo: nil repeats:NO];
    
    
}


- (void)swipeableView: (ZLSwipeableView *)swipeableView didSwipeRight:(UIView *)view
{
    

    
    
    CardView* card = (CardView*) view;
    [card.timer invalidate];
    card.timer = nil;
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
 


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
    
    self.swipeableView.dataSource = self;
    self.swipeableView.delegate = self;
    
    UIColor* color =BASE_COLOR;
    
   
    
    
    _swipeableView.backgroundColor = color;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(timerFired:)
                                                 name:@"TimerFired"  object:nil];
 
 
}

-(IBAction)timerFired:(id)sender
{
    
}
- (IBAction)startDeleting:(id)sender
{
    
     [self.swipeableView swipeTopViewToLeft];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    
    [self.swipeableView setNeedsLayout];
    [self.swipeableView layoutIfNeeded];
    
}





- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}
- (void)swipeableView: (ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location {
   
}
- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location {
    
}

#pragma mark - ZLSwipeableViewDataSource
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    
      if(!_isStarted)
      {
        _isStarted=YES;
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        view.cardColor = [UIColor whiteColor];
        view.imageView.hidden = YES;
          view.mainLabel.text = NSLocalizedString(@"Clean",@"clean files from device hard drive");
          [view setImagesAllGood];
        [view showHintGreen];
        [view showStartIcon];
        return view;
      }
    
    return nil;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
