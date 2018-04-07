//
//  CPConfig.h
//  Charging
//
//  Created by ToneWang on 2018/3/30.
//  Copyright © 2018年 dbmao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYBHomePortModel.h"

@interface CPConfig : NSObject

@property (nonatomic ,strong)NSString   *city;

+ (CPConfig *)sharedManager;

- (void)saveLastPort:(JYBHomePortModel *)port;

- (JYBHomePortModel *)lastPort;


- (NSString *)totalAmount;

- (void)saveTotalAmount:(NSString *)amount;

@end
