//
//  CPConfig.m
//  Charging
//
//  Created by ToneWang on 2018/3/30.
//  Copyright © 2018年 dbmao. All rights reserved.
//

#import "CPConfig.h"
#define CPPortPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"port.plist"]

@implementation CPConfig

+ (CPConfig *)sharedManager{
    static CPConfig *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[CPConfig alloc] init];
    });
    return sharedManager;
}



- (void)saveLastPort:(JYBHomePortModel *)port
{
    if (port == nil) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:CPPortPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:CPPortPath error:nil];
        }
        return;
    }
    
    NSString *path = CPPortPath;
    [NSKeyedArchiver archiveRootObject:port toFile:path];
}

- (JYBHomePortModel *)lastPort
{
    NSString *path = CPPortPath;
    if (![[NSFileManager defaultManager] fileExistsAtPath:CPPortPath]) {
        return nil;
    }
    JYBHomePortModel *port = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return port;
}

- (NSString *)totalAmount{
    return @"132454";
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"totalAmount"];
}

- (void)saveTotalAmount:(NSString *)amount{
    [[NSUserDefaults standardUserDefaults] setValue:amount forKey:@"totalAmount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
