//
//  LGCityPickerView.m
//  LoveGoMall
//
//  Created by LOVEGO on 16/9/29.
//  Copyright © 2016年 tiny. All rights reserved.
//


#import "LGCityPickerView.h"
#import "Masonry.h"
#import "LGProvinceModel.h"

@interface LGCityPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIView * bottomBgView;
@property (copy, nonatomic)   LGPickerComplete completeBlock;

@property (strong, nonatomic) UIPickerView * itemPicker;
@property (strong, nonatomic) NSArray *items;

@end

@implementation LGCityPickerView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(220);
    }];
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0, - 1.0 / kScreenScale);
    bgView.layer.shadowOpacity = 0.5;
    
    UIView * barView = [[UIView alloc] init];
    barView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.left.equalTo(bgView);
        make.right.equalTo(bgView);
        make.height.mas_equalTo(39);
    }];
    //设置阴影
//    barView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    barView.layer.shadowOffset = CGSizeMake(0, 1.0 / kScreenScale);
//    barView.layer.shadowOpacity = 0.5;
    barView.backgroundColor = RGB(245, 245,245);
    
    self.bottomBgView = bgView;
    
    UIButton * leftBtn = [[UIButton alloc] init];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [barView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(barView);
        make.top.equalTo(barView);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(60);
    }];
    
    UIButton * rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn addTarget:self action:@selector(comfirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [barView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(barView);
        make.top.equalTo(barView);
        make.height.mas_equalTo(39);
        make.width.mas_equalTo(60);
    }];
}

#pragma mark - Setter and getter
- (UIPickerView *)itemPicker {
    if (!_itemPicker) {
        _itemPicker = [[UIPickerView alloc] init];
        _itemPicker.dataSource = self;
        _itemPicker.delegate = self;
    }
    return _itemPicker;
}


#pragma mark - Delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return self.items.count;
    }
    else
    {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        LGProvinceModel *model = [self.items objectAtIndex:rowProvince];
        return model.city.count;
    }
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    static NSInteger lastRow = 0;
    if (component == 0) {
        if (lastRow !=row) {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            lastRow = row;
        }
    }
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        //        tView.minimumFontSize = 14;
        //        tView.adjustsLetterSpacingToFitWidth = YES;
    }
    switch (component) {
        case 0:
        {
            LGProvinceModel *model = [self.items objectAtIndex:row];
            tView.text = model.name;
        }
            break;
        case 1:
        {
            NSInteger rowProvince = [pickerView selectedRowInComponent:0];
            LGProvinceModel *model = [self.items objectAtIndex:rowProvince];
            
            //        NSInteger rowCity = [pickerView selectedRowInComponent:1];
            LGProvinceModel *cityModel = [model.city objectAtIndex:row];
            tView.text =cityModel.name;
        }
            break;
        default:
            tView.text =   @"";
            break;
    }
    return tView;
}

#pragma mark - Event response
- (void) cancelButtonClick {
    if (self.completeBlock) {
        self.completeBlock(self, nil);
    }
}

- (void) comfirmButtonClick {
    if (self.completeBlock) {
        //
        NSInteger provinceIndex = [self.itemPicker selectedRowInComponent:0];
        NSInteger cityIndex = [self.itemPicker selectedRowInComponent:1];
        //        //根据标示查询数组组合字符串然后回调
        LGProvinceModel *provinceModel = [self.items objectAtIndex:provinceIndex];
        LGProvinceModel *cityModel = [provinceModel.city objectAtIndex:cityIndex];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        if (provinceModel) {
            [dict setValue:provinceModel.name forKey:@"provCode"];
            if (cityModel) {
                [dict setValue:cityModel.name forKey:@"cityCode"];
            }
        }

        self.completeBlock(self,dict);
    }
}

#pragma mark - Public method

- (void) animationShowWithItems:(NSArray*)items selectedItemComplete:(LGPickerComplete)complete {
    self.completeBlock = complete;
    self.items = items;
    //    if (_datePicker) {
    //        [_datePicker removeFromSuperview];
    //    }
    [self.itemPicker reloadAllComponents];
    
    [self animationShowContentWithPicker:self.itemPicker];
}

- (void) animationShowContentWithPicker:(UIView *)picker {
    
    [self addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomBgView);
        make.right.equalTo(self.bottomBgView);
        make.bottom.equalTo(self.bottomBgView);
        make.top.equalTo(self.bottomBgView).with.offset(40);
    }];
    
    [self.bottomBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(200);
    }];
    [self layoutIfNeeded];
    
    self.hidden = NO;
    
    [self.bottomBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
}

- (void) animationDismiss {
    [self.bottomBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(200);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
@end
