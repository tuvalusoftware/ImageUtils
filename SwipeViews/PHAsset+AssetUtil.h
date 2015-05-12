//
//  PHAsset+AssetUtil.h
//  iCurate
//
//  Created by TouchROI on 12/14/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (AssetUtil)
@property (nonatomic, strong) PHAsset* associatedObject;

- (void)setAssociatedObject:(id)object;
- (id)associatedObject;
@end
