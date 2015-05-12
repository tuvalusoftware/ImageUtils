//
//  DropDownViewCell.m
//  KDropDownMultipleSelection
//
//  Created by macmini17 on 03/01/14.
//  Copyright (c) 2014 macmini17. All rights reserved.
//

#import "DropDownViewCell.h"
#import "Configs.h"

@implementation DropDownViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = TEXT_COLOR;
        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectOffset(self.imageView.frame, 6, 0);
    self.textLabel.frame = CGRectOffset(self.textLabel.frame, 6, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) filesCrusshed
{
    
    
}



-(void) fileDeleted
{
    
}
-(void) fileSize:(float) f
{
    
}

-(void) fileAggregate:(float) f
{
    
}

-(void) finished:(NSArray*)array
{
    
}

-(void) oneFilesSize:(float) size
{
    
}

-(void)  trueFilesSize:(float) size
{
    
}

-(void)  filesRemovedOfSize:(float) size
{
    
}

-(void) fileSizeWithId:(float) f  ID:(int) photoId
{
    
}



@end
