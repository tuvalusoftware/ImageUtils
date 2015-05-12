//
//  TVSStartWithDropdown.h
//  iCurate
//
//  Created by TouchROI on 12/14/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipePickBaseController.h"
@class DropDownListView;

@interface TVSStartWithDropdown : SwipePickBaseController
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchControl;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *information;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


 

@property BOOL favoritesExist;
-(NSString*) alertText;
@end
