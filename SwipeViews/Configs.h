//
//  Configs.h
//  SwipeViews
//
//  Created by TouchROI on 12/26/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//
#import "StringConstants.h"
#import "UIColor+JFMinimalNotificationColors.h"
 #ifndef SwipeViews_Configs_h
#define SwipeViews_Configs_h


typedef enum {
  FileOperationDelete=1,
   FileOperationScrub,
   FileOperationSearchFavorites,
   FileOperationCleanFavorites
}  FileOperation;



typedef enum {
    TotalMegabyte=1,
    CrushedMegabytes,
    NumberOfPhotos,

}   DataType;

#define OPERATION_DELETE @"DEL"

#define DEL   @{@"startLabel":kStringButtonStart,@"operation":FileOperationDelete,@"display":TotalMegabyte}

#define ATTRIBUTE_DICTIONARY @{OPERATION_DELETE:DEL}
//paperColorRed400

//paperColorTeal400

//#define BASE_COLOR [UIColor paperColorRed400]

//#define BASE_COLOR  [UIColor notificationRedColor]
#define BASE_COLOR [UIColor colorWithRed:54.0f/255.0f green:205.0f/255.0f blue:253.0f/255.0f alpha:1]

#define TEXT_COLOR   [UIColor whiteColor]
#define TEXT_COLOR2  [UIColor blackColor]

#endif
