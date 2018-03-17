//
//  JYBHomeSendDriveMesgVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"


@protocol JYBHomeSendDriveMesgVCDelegate <NSObject>

- (void)selectDriveMessage:(NSString *)message;

@end

@interface JYBHomeSendDriveMesgVC : CCBaseViewController

@property (nonatomic ,weak)id <JYBHomeSendDriveMesgVCDelegate>delegate;

@end
