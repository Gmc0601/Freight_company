//
//  JYBHomeSelectStationVC.m
//  Freight_Company
//
//  Created by ToneWang on 2018/3/16.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomeSelectStationVC.h"
#import "JYBHomeSeleStationHeaderView.h"
#import "LGCityPickerView.h"
#import "AppDelegate.h"
#import "LGProvinceModel.h"
#import "JYBHomeSeleStaionCell.h"

@interface JYBHomeSelectStationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)JYBHomeSeleStationHeaderView *headerView;

@property (nonatomic ,strong)LGCityPickerView *cityPickerView;

@property (nonatomic ,strong)NSString   *province;

@property (nonatomic ,strong)NSString    *city;

@property (nonatomic ,strong)NSMutableArray     *portArr;

@property (nonatomic ,strong)UITableView *myTableView;

@property (nonatomic ,strong)AMapSearchAPI *search;

@end

@implementation JYBHomeSelectStationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetFather];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.myTableView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SizeWidth(60));
    }];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.right.and.bottom.equalTo(self.view);
    }];
    
}

- (void)resetFather {
    self.titleLab.text = self.isPoint?@"选择装箱点":@"选择装箱区域";
    self.rightBar.hidden = YES;
}


-(NSArray *)getBPCityList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bpCityList.plist" ofType:nil];
    NSArray * newData = [NSArray arrayWithContentsOfFile:path];
    return newData;
}

- (void)citySelectAction{
    
    NSArray *cityArr = [self getBPCityList];
    NSMutableArray *cityModelArr = [[NSMutableArray alloc] init];
    for (NSDictionary *subDic in cityArr) {
        LGProvinceModel *model = [LGProvinceModel modelWithDictionary:subDic];
        [cityModelArr addObject:model];
    }
    WeakSelf(weak)
    [self.cityPickerView animationShowWithItems:cityModelArr selectedItemComplete:^(LGCityPickerView *pickerView, NSDictionary *dict) {
        if ([dict allKeys].count > 1) {
            weak.province = [dict objectForKey:@"provCode"];
            weak.city = [dict objectForKey:@"cityCode"];
            [weak.headerView.cityBtn setTitle:weak.city forState:UIControlStateNormal];
        }
        [pickerView animationDismiss];
    }];
    
}


- (void)__searchAreaData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic addUnEmptyString:[NSString stringWithFormat:@"%@省",self.province] forKey:@"province"];
    [dic addUnEmptyString:[NSString stringWithFormat:@"%@市",self.city] forKey:@"city"];
    [dic addUnEmptyString:self.headerView.myTextField.text forKey:@"name"];
    
    [ConfigModel showHud:self];
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Public/getLoadArea" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            [weak.portArr removeAllObjects];
            for (NSDictionary *subDic in datadic[@"data"]) {
                JYBHomeStationSeleModel *model = [JYBHomeStationSeleModel modelWithDictionary:subDic];
                [weak.portArr addObject:model];
            }
            
            [weak.myTableView reloadData];
            
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
    
}


- (void)searchBtnAction{
    
    if ([NSString stringIsNilOrEmpty:self.city]) {
        [ConfigModel mbProgressHUD:@"请先选择城市" andView:nil];
        return;
    }
    
    if (self.isPoint) {
        AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
        tips.keywords = self.headerView.myTextField.text;
        tips.city = self.city;
        [self.search AMapInputTipsSearch:tips];
    }else{
        [self __searchAreaData];
    }
}


/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.portArr removeAllObjects];
    //解析response获取提示词，具体解析见 Demo
    
    [self.portArr addObjectsFromArray:response.tips];
    [self.myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.portArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SizeWidth(55);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JYBHomeSeleStaionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYBHomeSeleStaionCell class]) forIndexPath:indexPath];
    if (self.isPoint) {
        AMapTip *tip = [self.portArr objectAtIndex:indexPath.row];
        cell.nameLab.text = tip.name;

    }else{
        JYBHomeStationSeleModel *model = [self.portArr objectAtIndex:indexPath.row];
        cell.nameLab.text = model.loadarea_name;
    }

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isPoint) {
        AMapTip *tip = [self.portArr objectAtIndex:indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectPoint:)]) {
            [self.delegate selectPoint:tip provice:self.province city:self.city];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        JYBHomeStationSeleModel *model = [self.portArr objectAtIndex:indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectStationModel:)]) {
            [self.delegate selectStationModel:model];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (JYBHomeSeleStationHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[JYBHomeSeleStationHeaderView alloc] init];
        [_headerView.cityBtn addTarget:self action:@selector(citySelectAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.arrowBtn addTarget:self action:@selector(citySelectAction) forControlEvents:UIControlEventTouchUpInside];        
        [_headerView.searchBtn addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

- (LGCityPickerView *)cityPickerView {
    if (!_cityPickerView) {
        _cityPickerView = [[LGCityPickerView alloc] init];
        _cityPickerView.hidden = YES;
        AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow *keyWindow =appDelegate.window;
        [keyWindow addSubview:_cityPickerView];
        [_cityPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(keyWindow);
        }];
        [keyWindow layoutIfNeeded];
    }
    return _cityPickerView;
}

- (NSMutableArray *)portArr{
    if (!_portArr) {
        _portArr = [[NSMutableArray alloc] init];
    }
    return _portArr;
}


- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myTableView.backgroundColor = RGB(245, 245, 245);
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[JYBHomeSeleStaionCell class] forCellReuseIdentifier:NSStringFromClass([JYBHomeSeleStaionCell class])];
    }
    return _myTableView;
}

@end
