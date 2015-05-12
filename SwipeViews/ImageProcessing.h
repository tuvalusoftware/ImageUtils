//
//  ImageProcessing.h
//  ImageProcessing
//
//  Created by Tim O'Brien on 10/3/14.
//  Copyright (c) 2014 ORG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
#import <opencv2/opencv.hpp>
#endif

@interface ImageProcessing : NSObject

-(NSArray*) photoBoxedFaces:(UIImage*) image;
-(NSArray*) getFaces:(UIImage*) image;
-(UIImage*) photoWithBoxedFaces:(UIImage*) image;
-(UIImage*) resize:(UIImage*) inputImage  Size:(CGSize) newSize;

@end
