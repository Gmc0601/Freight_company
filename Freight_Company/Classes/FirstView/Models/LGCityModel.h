//
//  LGCityModel.h
//  LoveGoMall
//
//  Created by LOVEGO on 16/9/28.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGCityModel : NSObject

/**
 市名称
 */
@property (nonatomic,copy)NSString *name;

/**
 市对应id
 */
@property (nonatomic,copy)NSString * ID;

/**
 市邮编
 */
@property (nonatomic, strong) NSString *code;


@end
