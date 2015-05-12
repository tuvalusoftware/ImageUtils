/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  A collection view cell that displays a thumbnail image.
  
 */

#import "AAPLGridViewCell.h"

@interface AAPLGridViewCell ()
@property (strong) IBOutlet UIImageView *imageView;



@end

@implementation AAPLGridViewCell

- (void)setThumbnailImage:(UIImage *)thumbnailImage {
    _thumbnailImage = thumbnailImage;
    self.imageView.image = thumbnailImage;
}

-(void) toggleCheckmark:(BOOL) bValue
{
   
  
    
    if(bValue)
    {
        _checkMarkImage.image =[UIImage imageNamed:@"cb_glossy_on.png"];
        _isOff=NO;
    }
    else
    {
        _checkMarkImage.image =[UIImage imageNamed:@"cb_glossy_off.png"];
        _isOff=YES;
        
    }
    
    

}



@end
