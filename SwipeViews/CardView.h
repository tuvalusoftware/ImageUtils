//
//  CardView.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileInfoProtocol.h"
@import Photos;


@class SwipeCoverController;

@interface CardView : UIView<FileInfoProtocol>
@property UIColor *cardColor;
@property (strong) PHAsset *asset;

@property (strong) UIButton* reviewBtn;

@property (strong) UIImageView* imageView;
@property (strong) UILabel* mainLabel;
@property (strong) UILabel* topLabel;
@property (strong) UILabel* rateUsLabel;
 
@property (strong) NSString* topLabelString;
@property (strong) NSString * cardText;
@property (strong) NSNumber  * year;
@property (strong) NSNumber  * month;

@property (strong) UIImageView* leftDotImage;
@property (strong) UIImageView* rightDotDotImage;

@property (strong) UIImage *yesCheckImage;
@property (strong) UIImage *noXImage;

@property (strong) SwipeCoverController* leftCover;

@property (strong) UIImageView* startIcon;


@property (weak) SwipeCoverController* rightCover;
@property (weak) NSTimer * timer;

@property  BOOL  isSwiped;

@property float tempValue;
@property float deletedMBs;

-(void) calculateYearMB:(int) year View:(UIView*) view;
-(void) calculateMonthMB:(int) year Month:(int) month View:(UIView*) view;
-(void) calculateTotalMB:(NSArray*) array;
-(void) getaTrueFileSize:(PHAsset *) asset;

-(void) showStartIcon;


-(void) showHintGreen;
-(void) showHint;
-(void) hideHint;
-(void) setImageCheckX;
-(void) setImagesAllGood;
-(void) setImagesPhotoSelect;
-(void) showThumbImages;
-(void) showImagesRate;

@end
