//
//  FileDeleteProtocol.h
//  PhotoSelector
//
//  Created by TouchROI on 11/29/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FileDeleteProtocol <NSObject>

-(void) didFinishDeleting:(BOOL) success;
-(void) didFinishFavoriting:(BOOL) success;


@end
