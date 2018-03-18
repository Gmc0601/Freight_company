//
//  JYBHomeFetchBoxPortCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/12.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeFetchBoxPortCell.h"
#import "UIView+line.h"

@interface JYBHomeFetchBoxPortCell ()


@end


@implementation JYBHomeFetchBoxPortCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self.contentView addSubview:self.portLab];
    [self.portLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(SizeWidth(10));
        make.width.mas_greaterThanOrEqualTo(SizeWidth(10));
    }];
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, SizeWidth(15), 0, -SizeWidth(15))];
}

- (UILabel *)portLab{
    if (!_portLab) {
        _portLab = [[UILabel alloc] init];
        _portLab.textColor = [UIColor blackColor];
        _portLab.font = [UIFont boldSystemFontOfSize:SizeWidth(17)];
        _portLab.text = @"宁波港  ▼";
    }
    return _portLab;
}
@end
