//
//  FileInfoProtocol.h
//  PhotoSelector
//
//  Created by TouchROI on 11/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FileInfoProtocol <NSObject>

-(void) fileDeleted;
-(void) fileSize:(float) f   ;

-(void) fileAggregate:(float) f   ;

-(void) finished:(NSArray*)array;

-(void) oneFilesSize:(float) size;

-(void)  trueFilesSize:(float) size;

-(void) filesCrusshed;

-(void)  filesRemovedOfSize:(float) size;

-(void) fileSizeWithId:(float) f  ID:(int) photoId;


@end
