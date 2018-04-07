//
//  JYBHomePortModel.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomePortModel.h"

@implementation JYBHomePortModel



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.port_id forKey:@"port_id"];
    [aCoder encodeObject:self.port_name forKey:@"port_name"];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if (self) {
        self.port_id = [aDecoder decodeObjectForKey:@"port_id"];
        self.port_name = [aDecoder decodeObjectForKey:@"port_name"];
        
    }
    return self;
}

@end
