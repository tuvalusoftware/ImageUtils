//
//  PHAsset+AssetUtil.m
//  iCurate
//
//  Created by TouchROI on 12/14/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "PHAsset+AssetUtil.h"
#import <objc/runtime.h>

@implementation PHAsset (AssetUtil)

@dynamic associatedObject;

- (void)setAssociatedObject:(id)object {
    
    objc_setAssociatedObject(self, @selector(associatedObject), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC|OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject {
    return objc_getAssociatedObject(self, @selector(associatedObject));
}



@end
