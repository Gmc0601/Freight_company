
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

@property (nonatomic ,strong)NSMutableArray     *dataArr;

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

- (void)updateCellWithArr:(NSMutableArray *)arr{
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:arr];
    [self.myCollectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JYBHomeOtherCostItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYBHomeOtherCostItemCell class]) forIndexPath:indexPath];
    JYBHomeDotModel *model = [self.dataArr objectAtIndex:indexPath.row];
    [cell updateDotCellWithModel:model];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenW - SizeWidth(30))/2, SizeWidth(55));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SizeWidth(10), SizeWidth(10), SizeWidth(10), SizeWidth(10));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return SizeWidth(10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SizeWidth(10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JYBHomeDotModel *model = [self.dataArr objectAtIndex:indexPath.row];
    if (self.portBlock) {
        self.portBlock(model);
    }
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


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}


@end
