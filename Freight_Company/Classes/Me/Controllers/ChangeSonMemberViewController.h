//
//  ChangeSonMemberViewController.h
//  Freight_Company
//
//  Created by cc on 2018/1/19.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "CCBaseViewController.h"
#import "SonMemberViewController.h"

typedef enum ChangeMemberType {
    ChangeInfo = 0,
    AddMember 
}ChangeMemberType;

@interface ChangeSonMemberViewController : CCBaseViewController

@property (nonatomic, assign) ChangeMemberType type;

@property (nonatomic, retain) SonmemberModel *model;

@end
