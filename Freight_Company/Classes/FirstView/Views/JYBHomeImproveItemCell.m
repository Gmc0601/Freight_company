//
//  JYBHomeImproveItemCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/17.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeImproveItemCell.h"
#import "UIView+line.h"

@interface JYBHomeImproveItemCell ()

@property (nonatomic ,strong)UIButton   *iconBtn;

@property (nonatomic ,strong)UILabel    *titleLab;

@property (nonatomic ,strong)UIButton   *arrowBtn;

@property (nonatomic ,strong)NSIndexPath    *seleIndexPath;
@end

@implementation JYBHomeImproveItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.iconBtn];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.arrowBtn];
    
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(55);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.iconBtn.mas_right);
        make.right.equalTo(self.arrowBtn.mas_left).offset(-SizeWidth(5));
    }];
    
    [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-SizeWidth(5));
        make.width.mas_equalTo(SizeWidth(30));
    }];
    [self.contentView addLineWithInset:UIEdgeInsetsMake(-1, SizeWidth(15), 0, -SizeWidth(15))];

}

- (void)updateCellWithIcon:(NSString*)icon title:(NSString *)title placeholder:(NSString *)placeholder editIcon:(NSString *)editIcon indexPath:(NSIndexPath *)indexPaht{
    self.seleIndexPath = indexPaht;
    [self.iconBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.arrowBtn setImage:[UIImage imageNamed:editIcon] forState:UIControlStateNormal];
    if ([NSString stringIsNilOrEmpty:title]) {
        self.titleLab.text = placeholder;
        self.titleLab.textColor = RGB(162, 162, 162);
    }else{
//        self.titleLab.text = title;
//        self.titleLab.textColor = RGB(52, 52, 52);
        NSArray *mesArr = [title componentsSeparatedByString:@"\n"];
        if (mesArr.count > 1){
            NSString *first = [mesArr objectAtIndex:0];
            NSString *last = [mesArr objectAtIndex:1];
            NSRange firstRange = [title rangeOfString:first];
            NSRange lastRange = [title rangeOfString:last];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:title];
            [attStr addAttribute:NSForegroundColorAttributeName value:RGB(52, 52, 52) range:firstRange];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SizeWidth(16)] range:firstRange];

            [attStr addAttribute:NSForegroundColorAttributeName value:RGB(162, 162, 162) range:lastRange];
            [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SizeWidth(14)] range:lastRange];

            self.titleLab.attributedText = attStr;
            
        }else{
            self.titleLab.text = title;
            self.titleLab.textColor = RGB(52, 52, 52);
            self.titleLab.font = [UIFont systemFontOfSize:SizeWidth(16)];
        }
    }
    
}

- (void)arrowBtnAction{
    if (self.improveBlock) {
        self.improveBlock(self.seleIndexPath);
    }
}

#pragma mark - lazy

- (UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] init];
    }
    return _iconBtn;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:SizeWidth(16)];
        _titleLab.textColor = RGB(52, 52, 52);
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        [_arrowBtn setImage:[UIImage imageNamed:@"icon_gd"] forState:UIControlStateNormal];
        [_arrowBtn addTarget:self action:@selector(arrowBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowBtn;
}

@end
