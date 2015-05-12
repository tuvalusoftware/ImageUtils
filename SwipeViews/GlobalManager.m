//
//  GlobalManager.m
//  SwipeViews
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "GlobalManager.h"
#import "Configs.h"
#import "SelectorCreatorProtocol.h"


#import "TVSStartWithDropdown.h"
#import "TVSSwipeViewControllerYear.h"
#import "TVSSwipeViewControllerMonth.h"
#import "TVSSwipPickControllerClean.h"
#import "TVSSwipPickControllerConfirm.h"
#import "TVSSwipPickControllerFinish.h"




@implementation GlobalManager
{
    
    int _controllerCount;
    FileOperation  _operationType;
    
}

#pragma mark - initialization


/* handle the finish logic delete, favorite, etc */
-(void) handleFinish
{
    if([_parent respondsToSelector:@selector(handleFinish:)])
   {
      [_parent handleFinish:self];
   }
    
    
}

/* null all attributes */
-(void) clearAll
{
    
    _leftSwipeAssets=nil;
    _rightSwipeAssets=nil;
    _mbAggregate=nil;
    _mbAggregateDeleted=nil;
    _assetRemoveArray=nil;
    _numberFilesExcluded=0;
 
}


-(void) initializeView:(id<SelectorCreatorProtocol>) parent
{
    
    _parent =parent;
    
    _leftSwipeAssets = [NSMutableArray new];
    _rightSwipeAssets = [NSMutableArray new];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cancel:)
                                                 name:@"Canceled"  object:nil];
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(next:)
                                                 name:@"Next"  object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(repeat:)
                                                 name:@"Repeat"  object:nil];

    [self createControllers];
 
}

#pragma mark - controller creation

-(void) createControllers
{
    
 
    
    
    // _controllerCount=0;
    _controllers =  [_parent controllers];
    
    /* save value of current controller */
    _controllersR=_controllers;
    
    /* reversed list of controllers */
    _controllers =  [[_controllers reverseObjectEnumerator] allObjects];
    
    
    
    /* get the sceeen height */
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    /* set the height and width of each controller to be the device height and width*/
    UIViewController * ctrl;
    for( ctrl in _controllers )
    {
        ctrl.view.frame = CGRectMake(0,0,screenWidth,screenHeight);
    }
    
}

/* create a new instance of the controller and replace it in in the controller list*/

-(void) createNewControllers:(UIViewController*) controller
{

    _controllers =  [_parent createNewControllers:controller];
    _controllersR=_controllers;
    _controllers =  [[_controllers reverseObjectEnumerator] allObjects];
    UIViewController * ctrl;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    for( ctrl in _controllers )
    {
        ctrl.view.frame = CGRectMake(0,0,screenWidth,screenHeight);
    }
   
}








#pragma mark - notification handlers

- (void) next:(NSNotification*)notification {
    
    
    if(_controllerCount < [_controllersR count]-1)
    {
        
        UIViewController  * currentController =  [_controllersR objectAtIndex:_controllerCount++];

        //int temp = _controllerCount;
       [self createNewControllers:currentController];
        //_controllerCount = temp;

        UIViewController  * nextController =  [_controllersR objectAtIndex:_controllerCount];
        nextController.view.alpha=0;
        
       [nextController viewDidLoad];

        [self.view addSubview:nextController.view ];
        
        // [self.view insertSubview:_startDropdownController.view belowSubview:nextController.view ];
        
        [UIView animateWithDuration:.5
                              delay:0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             currentController.view.alpha =0;
                         }
                         completion:^(BOOL finished){
                             currentController.view.alpha =0;

                             [UIView animateWithDuration:.5
                                                   delay:0
                                                 options: UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  
                                                  nextController.view.alpha=1;
                                                  
                                              }
                                              completion:^(BOOL finished){
                                                  
                                                  
                                                  [currentController.view removeFromSuperview];

                                              }];

                         }];
        
    }
    else
    {
        
        [UIView animateWithDuration:.5
                              delay:.5
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             UIViewController* ctrl;
                             
                             for ( ctrl in _controllers)
                             {
                                 ctrl.view.alpha = 0;
                                 
                             }
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             UIViewController* ctrl;
                             for ( ctrl in _controllers)
                             {
                                 [ctrl.view  removeFromSuperview];
                                 ctrl.view.alpha = 1;
                                 
                             }
                             
                              [self createControllers];
                             ((UIViewController*) _controllersR[0]).view.alpha=0;
                             _controllerCount=0;
                             
                             
                           //  [self.view insertSubview:_startDropdownController.view belowSubview:_recommendButton];
                             
                             [self.view addSubview:((UIViewController*) _controllersR[0]).view];
                             
                             [UIView animateWithDuration:.5
                                                   delay:0
                                                 options: UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  
                                                  ((UIViewController*) _controllersR[0]).view.alpha=1;
                                                  
                                              }
                                              completion:^(BOOL finished){
                                                  
                                              }];
                         }];

    }
  
}




- (void) cancel:(NSNotification*)notification
{
    
    _controllerCount = [_controllers count] -1;
    [self next:notification];   
    
}


/* reload the view currently being displayed */
- (void) repeat:(NSNotification*)notification {
    
    
    UINavigationController<ReloadProtocol> *   currentController =  [_controllersR objectAtIndex:_controllerCount];
    
    currentController.view.alpha =0;
    [currentController reload];
    
    [UIView animateWithDuration:.5
                          delay:.3
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         
                         currentController.view.alpha=1;
                     }
                     completion:^(BOOL finished){
  
                     }];
 
}

#pragma mark - helper methos

-(void) loadView
{
    
    [self.view addSubview:((UIViewController*) _controllersR[0]).view];
    ((UIViewController*) _controllersR[0]).view.center= self.view.center;
    
 
    
    
}



#pragma mark - class initialization methods

- (instancetype)initWithType:(FileOperation) operationType View:(UIView*) view
{
    self = [super init];
    if (self) {
        _operationType=operationType;
        _view = view;
    }
    return self;
}



// assums the instance has already been created with operation and view
+ (id) sharedInstance
{
    
    return  [GlobalManager sharedInstance:FileOperationDelete View:nil];
    
}


/* create an instance of global manager with the operation and view type*/
+ (id) sharedInstance:(FileOperation) operation View:(UIView*) view
{
    static dispatch_once_t pred;
    static GlobalManager *manager = nil;
    /* executes only once for lifetime of appliclication */
    dispatch_once(&pred, ^{ manager = [[self alloc] initWithType:operation View:view]; });
    return manager;
}

@end
