//
//  JYBHomeSendDriveHeaderView.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/11.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSendDriveHeaderView.h"
#import "TYLimitedTextView.h"
#import "UITextView+FastKit.h"

@interface JYBHomeSendDriveHeaderView ()<TYLimitedTextViewDelegate>

@property (nonatomic ,strong)UIView                 *backView;          ///<背景

@property (nonatomic ,strong)TYLimitedTextView      *inputTextView;     ///<输入框

@property (nonatomic ,strong)UILabel                *lenthLabel;        ///<长度

@end

@implementation JYBHomeSendDriveHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    
    [self addSubview:self.backView];
    [self.backView addSubview:self.inputTextView];
    [self.backView addSubview:self.lenthLabel];
    
    self.backView.frame = CGRectMake(SizeWidth(10), SizeWidth(10), kScreenW - SizeWidth(20), SizeWidth(130));
    self.inputTextView.frame = CGRectMake(SizeWidth(10), SizeWidth(10), self.backView.width - SizeWidth(20), SizeWidth(90));
    self.lenthLabel.frame = CGRectMake(self.backView.width - SizeWidth(70), SizeWidth(110), SizeWidth(60), SizeWidth(20));

    
}

- (void)limitedTextViewDidChange:(UITextView *)textView{
    TYLimitedTextView *limitTextView = (TYLimitedTextView *)textView;
    self.lenthLabel.text = [NSString stringWithFormat:@"%ld/200",limitTextView.inputLength];
}

- (TYLimitedTextView *)inputTextView{
    if (!_inputTextView) {
    
    _inputTextView = [[TYLimitedTextView alloc] init];
    _inputTextView.realDelegate = self;
    _inputTextView.maxLength = 60;
    _inputTextView.placeholder = @"有什么需要交代司机的，请留言";
    _inputTextView.placeholderColor = RGB(162, 162, 162);
    _inputTextView.font = [UIFont systemFontOfSize:SizeWidth(13)];
    _inputTextView.backgroundColor = RGB(245, 245, 245);
    }
    return _inputTextView;
}


- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(245, 245, 245);
    }
    return _backView;
}

- (UILabel *)lenthLabel{
    if (!_lenthLabel) {
        _lenthLabel = [[UILabel alloc] init];
        _lenthLabel.font = [UIFont systemFontOfSize:SizeWidth(13)];
        _lenthLabel.textColor = RGB(162, 162, 162);
        _lenthLabel.text = @"0/60";
        _lenthLabel.textAlignment = NSTextAlignmentRight;
    }
    return _lenthLabel;
}

@end
