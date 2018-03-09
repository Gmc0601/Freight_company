//
//  MyDriverTableViewCell.m
//  Freight_Company
//
//  Created by cc on 2018/1/18.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "MyDriverTableViewCell.h"

@implementation MyDriverTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.addView];
        [self.addView addSubview:self.nameLab];
        [self.addView addSubview:self.carNumLab];
        [self.addView addSubview:self.teamLab];
    }
    return self;
}
- (void)update:(MYDriverModel *)model {
    self.nameLab.text = model.driver_name;
    self.carNumLab.text = model.car_no;
    self.teamLab.text = model.fleet_name;
}

- (UIView *)addView {
    if (!_addView) {
        _addView = [[UIView alloc] initWithFrame:FRAME(SizeWidth(10), SizeHeight(5), kScreenW - SizeWidth(20), SizeHeight(64))];
        _addView.backgroundColor = UIColorFromHex(0xF5F5F5);
        _addView.layer.masksToBounds = YES;
        _addView.layer.cornerRadius = 2;
    }
    return _addView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:FRAME(SizeWidth(15), SizeHeight(11.5), kScreenW/2, SizeHeight(17))];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.font = [UIFont boldSystemFontOfSize:18];
        _nameLab.textColor = UIColorFromHex(0x666666);
        _nameLab.text = @"张益达";
    }
    return _nameLab;
}

- (UILabel *)carNumLab {
    if (!_carNumLab) {
        _carNumLab = [[UILabel alloc] initWithFrame:FRAME(kScreenW/2 - SizeWidth(15), SizeHeight(11.5), kScreenW/2 - SizeWidth(30), SizeHeight(17))];
        _carNumLab.backgroundColor = [UIColor clearColor];
        _carNumLab.textAlignment = NSTextAlignmentRight;
        _carNumLab.font = [UIFont boldSystemFontOfSize:18];
        _carNumLab.textColor = UIColorFromHex(0x666666);
        _carNumLab.text = @"牛B 74110";
    }
    return _carNumLab;
}

- (UILabel *)teamLab {
    if (!_teamLab) {
        _teamLab = [[UILabel alloc] initWithFrame:FRAME(SizeWidth(15), SizeHeight(40), kScreenW/2, SizeHeight(17))];
        _teamLab.backgroundColor = [UIColor clearColor];
        _teamLab.font = [UIFont systemFontOfSize:13];
        _teamLab.textColor = UIColorFromHex(0x666666);
        _teamLab.text = @"集运帮八卦吧";
    }
    return _teamLab;
}

@end
