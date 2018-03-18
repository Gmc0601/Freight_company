//
//  JYBHomePackingInputCell.h
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYBHomePackingInputCell : UITableViewCell

@property (nonatomic ,strong)UILabel *titleLab;

@property (nonatomic ,strong)UITextField *myTextField;

- (void)updateCellWithTitle:(NSString *)title placeHoler:(NSString *)placeHoler value:(NSString *)value;

@end
