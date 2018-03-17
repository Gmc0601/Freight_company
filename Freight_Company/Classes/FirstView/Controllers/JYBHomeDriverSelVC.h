//
//  JYBHomeDriverSelVC.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CPHomeMyDriverModel.h"

@protocol JYBHomeDriverSelVCDelegate <NSObject>

- (void)selectDriverModel:(CPHomeMyDriverModel *)driverModel;

@end
@interface JYBHomeDriverSelVC : CCBaseViewController

@property (nonatomic ,weak)id <JYBHomeDriverSelVCDelegate>delegate;

@end
