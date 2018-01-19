//
//  AddInfoViewController.h
//  Freight_Company
//
//  Created by cc on 2018/1/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"

@interface AddInfoModel: NSObject

@property (nonatomic,copy) NSString *compayName, *userName, *phone, *QQ, *address, *photoStr;

@property (nonatomic) BOOL man;

@end

@interface AddInfoViewController : CCBaseViewController

@end
