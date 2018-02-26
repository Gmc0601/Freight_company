
//
//  JYBHomePortCostCell.m
//  Freight_Company
//
//  Created by ToneWang on 2018/2/13.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "JYBHomePortCostCell.h"
#import "JYBHomeOtherCostItemCell.h"

@interface JYBHomePortCostCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)UICollectionView *myCollectionView;

@end

@implementation JYBHomePortCostCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self p_initUI];
    }
    return self;
}

- (void)p_initUI{
    [self.contentView addSubview:self.myCollectionView];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JYBHomeOtherCostItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYBHomeOtherCostItemCell class]) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenW - SizeWidth(30)-SizeWidth(10))/2, SizeWidth(55));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, SizeWidth(15), SizeWidth(5), SizeWidth(15));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置最小行间距
        flowLayout.minimumLineSpacing = 0;
        //最小列间距
        flowLayout.minimumInteritemSpacing = 0;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _myCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_myCollectionView registerClass:[JYBHomeOtherCostItemCell class] forCellWithReuseIdentifier:NSStringFromClass([JYBHomeOtherCostItemCell class])];
    }
    return _myCollectionView;
}


@end
