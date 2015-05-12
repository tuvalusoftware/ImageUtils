

#import "CardView.h"
#import "PhotoUtils.h"
#import "Configs.h"
#import "SwipeCoverController.h"


#define LABLE_HEIGHT 80
#define TOP_LABLE_HEIGHT 80
#define TOP_LABLE_FONT_SIZE 37
#define IMAGE_DIM 6

@implementation CardView
{
    float _yearAggregate;
    float _mbAggregate;
}


/* method implementations for FileInfoProtocol */
-(void) fileDeleted{};
-(void) finished:(NSArray*)array{};
-(void) oneFilesSize:(float)size{};
-(void) filesCrusshed{};


-(void) showHint
{
    
    
    UIImage * greenDotImg =  [UIImage imageNamed:@"green.jpg"];
    UIImage * redDotImg =  [UIImage imageNamed:@"red.jpeg"];
    
    
    _yesCheckImage = [UIImage imageNamed:@"checkmark.png"];
    _noXImage =      [UIImage imageNamed:@"cancel.jpeg"];
    
    [_leftDotImage removeFromSuperview];
    [_rightDotDotImage removeFromSuperview];
    _leftDotImage     = [[UIImageView alloc] initWithImage:greenDotImg];
    _rightDotDotImage = [[UIImageView alloc] initWithImage:redDotImg];
    
    
    CGRect screenRect = self.frame;
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    _leftDotImage.frame = CGRectMake( 2,  screenHeight/2 - IMAGE_DIM, IMAGE_DIM, IMAGE_DIM);
    _rightDotDotImage.frame = CGRectMake(screenWidth -7, screenHeight/2 - IMAGE_DIM, IMAGE_DIM, IMAGE_DIM);
    
    [self   addSubview:_leftDotImage];
    [self    addSubview:_rightDotDotImage];
    
    
    
    
}


-(void) hideHint
{
    [_leftDotImage removeFromSuperview];
    [_rightDotDotImage removeFromSuperview];
    
}


-(void) showHintGreen
{
    [_leftDotImage removeFromSuperview];
    [_rightDotDotImage removeFromSuperview];
    UIImage * greenDotImg =  [UIImage imageNamed:@"green.jpg"];
    UIImage * redDotImg =  [UIImage imageNamed:@"green.jpg"];
    
    
    _leftDotImage     = [[UIImageView alloc] initWithImage:greenDotImg];
    _rightDotDotImage = [[UIImageView alloc] initWithImage:redDotImg];
    
    
    CGRect screenRect = self.frame;
    CGFloat screenWidth = screenRect.size.width;
  
    
    CGPoint point =   self.center;
    
    
    _leftDotImage.frame = CGRectMake( 5,  point.y, IMAGE_DIM, IMAGE_DIM);
    _rightDotDotImage.frame = CGRectMake(screenWidth -10,point.y, IMAGE_DIM, IMAGE_DIM);
    
    [self   addSubview:_leftDotImage];
    [self    addSubview:_rightDotDotImage];
    
    
    
    
}



-(void) updateForDeletedFile:(NSArray*) array
{
    [PhotoUtils countDownRemovedFile:array Result:self];
    
}


-(void)  filesRemovedOfSize:(float) size
{
    _deletedMBs=size;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:_yearAggregate-_deletedMBs]];
    NSString * resStr = [NSString stringWithFormat:@"%@ MB",numberString];
    _topLabel.text = resStr;
   
    
}


// should have loaded the main label firest. fix later
-(void) showStartIcon
{
    
    CGRect rect = _mainLabel.frame;
    _mainLabel.frame = CGRectMake(rect.origin.x, rect.origin.y-47, rect.size.width, rect.size.height);
    
    rect = _mainLabel.frame;
    
    
    UIImage* image = [UIImage imageNamed:@"start_icon.png"];
    
    _startIcon  = [[UIImageView alloc] initWithImage:image];
    
    _startIcon.frame =
    CGRectMake(self.center.x -.5*100, rect.origin.y  + LABLE_HEIGHT+5,100,120);
    
    [self addSubview:_startIcon];
    
    
    
    
    
    
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //// Color Declarations
        UIColor* shadowColor2 = [UIColor grayColor];
        
        //// Shadow Declarations
        UIColor* shadow = [shadowColor2 colorWithAlphaComponent: 0.73];
        CGSize shadowOffset = CGSizeMake(3.1/2.0, -0.1/2.0);
        CGFloat shadowBlurRadius = 12/2.0;
        self.layer.shadowColor = [shadow CGColor];
        self.layer.shadowOpacity = 0.73;
        self.layer.shadowOffset = shadowOffset;
        self.layer.shadowRadius = shadowBlurRadius;
        self.layer.shouldRasterize = YES;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(frame.origin.x -8,frame.origin.y -5, frame.size.width -16, frame.size.height -10);
        _imageView.center = self.center;
        _imageView.contentMode= UIViewContentModeScaleToFill;
        
       
        _reviewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,frame.size.height -40,  frame.size.width ,40)];
    
        [_reviewBtn  setTitle:NSLocalizedString(@"review", @"brings up a review dialog") forState:UIControlStateNormal];
        [_reviewBtn.titleLabel setTextAlignment: NSTextAlignmentCenter];
        
        [_reviewBtn.titleLabel setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:20]];
        
        
        UIColor* color =BASE_COLOR;
        
        
         [_reviewBtn setTitleColor:color forState:UIControlStateNormal];
        
   
        
        [_reviewBtn addTarget:self action:@selector(details:) forControlEvents:UIControlEventTouchUpInside];
        
        CGPoint point = self.center;
        
        _rateUsLabel= [[UILabel alloc] initWithFrame:CGRectMake(20 ,frame.size.height/2 +45,   frame.size.width-40 ,30)];
        
        _rateUsLabel.center=  CGPointMake(point.x, frame.size.height/2 +45);
        
    
        _rateUsLabel.text =NSLocalizedString(@"rate in app store?",@"rate the app in the Apple app store");
        [_rateUsLabel setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:20]];
        _rateUsLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        [_rateUsLabel setTextColor:color];
        _rateUsLabel.adjustsFontSizeToFitWidth = YES;
        _rateUsLabel.hidden = YES;
          
        _mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 ,frame.size.height/2 -LABLE_HEIGHT/2-3,    frame.size.width-40 ,LABLE_HEIGHT)];
        
        
        [_mainLabel setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:52]];
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        
        [_mainLabel setTextColor:color];
        _mainLabel.adjustsFontSizeToFitWidth = YES;
       
        
        
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 , 15,  frame.size.width-4 ,TOP_LABLE_HEIGHT)];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        
         [_topLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size: TOP_LABLE_FONT_SIZE] ];
         [_topLabel setTextColor:color];
        
        
        _leftCover = [[SwipeCoverController alloc] initWithNibName:@"SwipeCoverController" bundle:nil];
 
        _leftCover.view.frame  = frame;
        _rightCover.view.frame = frame;
        
        _leftCover.view.alpha  = 0;
        _rightCover.view.alpha = 0;
        
        [self addSubview:_topLabel];
        [self addSubview:_mainLabel];
        [self addSubview:_rateUsLabel];
        [self addSubview:_imageView];
        [self addSubview:_reviewBtn];
        [self addSubview:_rightCover.view];
        [self addSubview:_leftCover.view];
        
        
        
        _reviewBtn.hidden = YES;
        
  
        
        
        [self showHint];
        
       /* _timer = [NSTimer scheduledTimerWithTimeInterval:.2
                                         target:self
                                       selector:@selector(onTick:)
                                       userInfo:nil
                                        repeats:YES];
        
        */
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(timerFired:)
                                                     name:@"TimerFired"  object:nil];
        
        
        
        
        
        
       
        
        
    }
    return self;
}

-(void) setImagesPhotoSelect
{
    _yesCheckImage = [UIImage imageNamed:@"greeGarbage.jpeg"];
    _noXImage =      [UIImage imageNamed:@"keep.jpeg"];
    
}
-(void) showThumbImages
{
    _yesCheckImage = [UIImage imageNamed:@"thumbsUp.png"];
    _noXImage =      [UIImage imageNamed:@"thumbsDown.png"];
    
}
-(void) showImagesRate 
{
    _yesCheckImage = [UIImage imageNamed:@"stars.png"];
    _noXImage =      [UIImage imageNamed:@"cancel.jpeg"];
    
    _leftCover.imageView.hidden = YES;
    _leftCover.largeImage.hidden = NO;
    
    _rightCover.imageView.hidden = YES;
    _rightCover.largeImage.hidden = NO;
    
    
}

-(void) setImagesAllGood
{
    _yesCheckImage = [UIImage imageNamed:@"checkmark.png"];
    _noXImage =      [UIImage imageNamed:@"checkmark.png"];
    
}


-(void) setImageCheckX
{
    _yesCheckImage = [UIImage imageNamed:@"checkmark.png"];
    _noXImage =      [UIImage imageNamed:@"cancel.jpeg"];
    
}

-(IBAction)timerFired:(id)sender
{
    [self onTick];
    
}

-(void)onTick
{
    
  
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    // half screen width
    float halfScreenWidth = screenWidth/2;
    float horizontalMotion = halfScreenWidth-self.frame.origin.x;
    
 
 
    
    if(self.frame.origin.x  < 5 )
    {
        
        
        _leftCover.imageView.image = _yesCheckImage;
  
        // lets get the distance traveled as a percent of distance
        float distance = halfScreenWidth -horizontalMotion;
        _leftCover.view.alpha =  -distance/halfScreenWidth;

    }
    else if(self.frame.origin.x > 5)
    {
        _leftCover.imageView.image = _noXImage;
        float distance =   ( horizontalMotion-halfScreenWidth) ;
        // lets get the distance traveled as a percent of distance
        _leftCover.view.alpha =  -distance/halfScreenWidth ;

    }
    
   
}




-(IBAction)details:(id)sender
{
    
    //NSLog(@"details");
}

-(void) calculateYearMB:(int) year View:(UIView*) view
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
          [PhotoUtils photoSizeYear:year Result:self ParentView:view];
    });
    
}


-(void) calculateTotalMB:(NSArray*) array
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
         [PhotoUtils photoSizeArrayOfPHAsset:array Result:self];
    });
}

-(void) calculateMonthMB:(int) year Month:(int) month View:(UIView*) view
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
          [PhotoUtils photoSizeMonth:year  Month:month Result:self ParentView:view];
      });
}




-(void) fileSizeWithId:(float) f    ID:(int) photoId
{
 
    [self fileSize:f];
    
  
    
    //AppDelegate *appDelegate        = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 
   // NSNumber*  timeMillisecs        =  [NSNumber numberWithLong :photoId];
    //NSNumber*  sizeOfImage          =  [NSNumber numberWithFloat:f];
   // [appDelegate.sizeOfAssets setObject:sizeOfImage  forKey:timeMillisecs];
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



-(void) getaTrueFileSize:(PHAsset *) asset

{
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:.3
                                     target:self
                                   selector:@selector(onTick:)
                                   userInfo:nil
                                    repeats:YES];
    

    
  
    
}





-(void) onTick:(NSTimer*) timer
{
    assert(self.asset);
    if(!_isSwiped)
    {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [PhotoUtils trueFilesSize:self.asset Result:self];
    });
    }
    
    
    
    
    
    
}


-(void)  trueFilesSize:(float) size
{
    
    _tempValue =size;
      NSString * labelText = [self formatNumber:size];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
       self.topLabel.text = labelText;
        
    });
    
}


-(void) fileAggregate:(float) f
{

    
    _yearAggregate+= f;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:_yearAggregate]];
    NSString * resStr = [NSString stringWithFormat:@"%@ MB",numberString];
    _topLabel.text = resStr;
    
    
}

-(void) fileSize:(float) f
{
    
 
    
    _yearAggregate+= f;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:_yearAggregate]];
    NSString * resStr = [NSString stringWithFormat:@"%@ MB",numberString];
    _topLabel.text = resStr;
    
    
    
        
}



-(void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGFloat frameWidth = rect.size.width;
    CGFloat frameHeight = rect.size.height;
    CGFloat cornerRadius = 10;
    
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* cardColor = self.cardColor;
    
    
    //// card1
    {
        CGContextSaveGState(context);
        //        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
        CGContextBeginTransparencyLayer(context, NULL);
        
        //// Rectangle 4 Drawing
        UIBezierPath* rectangle4Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, frameWidth, frameHeight) cornerRadius: cornerRadius];
        [cardColor setFill];
        [rectangle4Path fill];
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }
}

-(void)dealloc
{
 
 
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
   
  
}
@end
