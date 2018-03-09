//
//  LoginViewController.h
//  BaseProject
//
//  Created by cc on 2017/12/12.
//  Copyright © 2017年 cc. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CompanyInfo : NSObject

@property (nonatomic, copy) NSString *company_name, *company_status, *refund_desc, *total_amount;

@end
@interface UserModel : NSObject

@property (nonatomic , copy) NSString              * phone;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , copy) NSString              * company_id;
@property (nonatomic , strong) CompanyInfo          * company_info;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * head_img;
@property (nonatomic , copy) NSString              * user_name;

@end


@interface LoginViewController : CCBaseViewController

@property (nonatomic, copy) void(^homeBlocl)();

@end
