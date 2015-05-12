//
//  TVSStartWithDropdown.m
//  iCurate
//
//  Created by TouchROI on 12/14/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "TVSStartWithDropdown.h"
#import "DropDownListView.h"
#import "PhotoUtils.h"
#import "Configs.h"
#import "GlobalManager.h"




@interface TVSStartWithDropdown ()

@end

@implementation TVSStartWithDropdown


#pragma mark - methods from UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated
{
     GlobalManager* gmMansger = [GlobalManager sharedInstance];
    [gmMansger clearAll];
 
    [super viewWillAppear:animated];
    [_startBtn setTitle:[self btnTitle]  forState:UIControlStateNormal];
    _descriptionLabel.text =[self mainLabelText];
    _descriptionLabel.textColor =TEXT_COLOR;
    [_startBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    
}


#pragma mark - button methods


- (IBAction)startButton:(id)sender
{
   if([self doCheck])
   {
    
       NSNotification *notification = [NSNotification notificationWithName:@"Next"  object:nil];
       [[NSNotificationQueue defaultQueue]
        enqueueNotification:notification
        postingStyle:NSPostASAP];
   }
   else
   {
       
      
       UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"No PHotos"
                                                        message:self.alertText
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
       
       [alert show];
       
       
   }
    
    
    
}


-(NSString*) alertText
{
    
    
    return NSLocalizedString(@"No Photos were found",@"no photos were found");
}



-(BOOL) doCheck
{
    int i;
    NSArray * arrayOfInteger= [PhotoUtils getArrayOfYear:&i];
    return (!([arrayOfInteger count] ==0));
}

-(NSString*)btnTitle
{
     return NSLocalizedString(@"Scrub",@"remove unwanted photos");
   
    
}


-(NSString*) mainLabelText
{
    return NSLocalizedString(@"Delete Unwanted Photos",@"remove unwanted photos")  ;
 
    
}


@end
