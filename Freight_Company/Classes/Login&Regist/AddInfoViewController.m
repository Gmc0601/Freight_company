//
//  AddInfoViewController.m
//  Freight_Company
//
//  Created by cc on 2018/1/15.
//  Copyright © 2018年 cc. All rights reserved.
//

#import "AddInfoViewController.h"
#import "AddInfoTableViewCell.h"
#import <YYKit.h>
#import "ReviewViewController.h"
#import "GTMBase64.h"


@implementation AddInfoModel

@end

@interface AddInfoViewController ()<UITableViewDelegate,  UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    BOOL isman;
    BOOL photo;
}

@property (nonatomic, retain) UIButton *commitBtn;

@property (nonatomic, retain) NSArray *titleArr;

@property (nonatomic, retain) UITableView *noUseTableView;

@property (nonatomic, retain) UIImageView *logoImage;

@property (nonatomic, retain) UIButton *man, *womam;

//@property (nonatomic, retain) AddInfoModel *model;

@end

@implementation AddInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isman = YES;
    [self resetFather];
    
//    self.model = [[AddInfoModel alloc] init];
    self.model.man = YES;
    photo = NO;
    
    
    [self.view addSubview:self.noUseTableView];
    [self.view addSubview:self.commitBtn];
}

- (void)resetFather {
    self.titleLab.text = @"完善企业信息";
    self.rightBar.hidden =  YES;
    
}

- (void)back:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [ NSString stringWithFormat:@"%lu", (long)indexPath.row];

    AddInfoTableViewCell *cell = [self.noUseTableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AddInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        if (indexPath.row == 1) {
            [cell.contentView addSubview:self.man];
            [cell.contentView addSubview:self.womam];
            self.man.top = 17.5;
            self.womam.top = 17.5;
            cell.text.width = kScreenW/2 - SizeWidth(50);
        }
        
    }
    cell.title = self.titleArr[indexPath.row];

    if (indexPath.row == 0 || indexPath.row == 1) {
        
        [self fuwenbenLabel:cell.titleLab FontNumber:14 AndRange:[self allStr:self.titleArr[indexPath.row] with:@"*"] AndColor:[UIColor redColor]];
    }
    
    cell.textBlock = ^(NSString *text) {
        switch (indexPath.row) {
            case 0:
                self.model.compayName = text;
                break;
            case 1:
                self.model.userName = text;
                break;
            case 2:
                self.model.phone = text;
                break;
            case 3:
                self.model.QQ =  text;
                break;
            case 4:
                self.model.address = text;
                break;
                
            default:
                break;
        }
    };
    
    return cell;
    
}

- (NSRange)allStr:(NSString *)allstr with:(NSString *)str {
    NSString *tmpStr = allstr;
    NSRange range;
    range = [tmpStr rangeOfString:str];
    return range;
}
-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(CGFloat)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    //设置字号
    //[str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    labell.attributedText = str;
}

#pragma mark - UITableDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (UITableView *)noUseTableView {
    if (!_noUseTableView) {
        _noUseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64- SizeHeight(50)) style:UITableViewStylePlain];
        _noUseTableView.backgroundColor = [UIColor whiteColor];
        _noUseTableView.delegate = self;
        _noUseTableView.dataSource = self;
        _noUseTableView.tableHeaderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
            view;
        });
        _noUseTableView.tableFooterView = ({
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW,  SizeHeight(553/2))];
            view.backgroundColor = [UIColor whiteColor];
            
            UILabel *line = [[UILabel alloc] initWithFrame:FRAME(15, 0, kScreenW, 1)];
            line.backgroundColor = RGB(239, 240, 241);
            [view addSubview:line];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:FRAME(SizeWidth(10), SizeHeight(25), kScreenW/2, SizeHeight(25))];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:13];
            lab.text = @"企业营业执照";
            [view addSubview:lab];
            
            [view addSubview:self.logoImage];
            
            UIButton *btn = [[UIButton alloc] init];
            btn.frame = self.logoImage.frame;
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(addimage) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
            
            view;
        });
    }
    return _noUseTableView;
}

#pragma mark -- Photo
- (void)takeAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}


- (void)takePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alter show];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    photo = YES;
    self.logoImage.image = editedImage;
    
    NSData *imgData = UIImageJPEGRepresentation(editedImage,0.5);
    NSString *imgStr = [GTMBase64 stringByEncodingData:imgData];
    
    self.model.photoStr = imgStr;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)commitClick {

    if (!self.model.compayName) {
        [ConfigModel mbProgressHUD:@"请输入企业全称" andView:nil];
        return;
    }
    
    if (!self.model.userName) {
        [ConfigModel mbProgressHUD:@"请输入联系人" andView:nil];
        return;
    }
    [ConfigModel showHud:self];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:self.model.user_id  forKey:@"user_id"];
    
    [dic setValue:self.model.compayName forKey:@"company_name"];
    
    [dic setValue:self.model.userName forKey:@"linkman"];
    
    [dic setValue:self.model.company_id forKey:@"company_id"];
    
    if (isman) {
        [dic setValue:@"1" forKey:@"linkman_sex"];
    }else {
        [dic setValue:@"0" forKey:@"linkman_sex"];
    }
    
    if (self.model.phone) {
        [dic setObject:self.model.phone forKey:@"company_phone"];
    }
    
    if (self.model.QQ) {
        [dic setObject:self.model.QQ forKey:@"qq"];
    }
    
    if (self.model.address) {
        [dic setObject:self.model.address forKey:@"address"];
    }
    
    if (photo) {
        [dic setObject:self.model.photoStr forKey:@"company_licence_img"];
    }
    NSLog(@"%@", dic);
    WeakSelf(weak)
    [HttpRequest postPath:@"/Home/Public/companyAddOrEdit" params:dic resultBlock:^(id responseObject, NSError *error) {
        [ConfigModel hideHud:weak];
        NSLog(@"%@", responseObject);
        if([error isEqual:[NSNull null]] || error == nil){
            NSLog(@"success");
        }
        NSDictionary *datadic = responseObject;
        if ([datadic[@"success"] intValue] == 1) {
            ReviewViewController *vc = [[ReviewViewController alloc] init];
            vc.type = Reviewing;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            NSString *str = datadic[@"msg"];
            [ConfigModel mbProgressHUD:str andView:nil];
        }
    }];
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:FRAME(10, kScreenH - SizeHeight(45), kScreenW - 20, SizeHeight(40))];
        [_commitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
        _commitBtn.backgroundColor = RGB(24, 141, 240);
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"企业全称*", @"企业联系人*", @"联系电话", @"联系人QQ", @"办公地址"];
    }
    return _titleArr;
}

- (UIImageView *)logoImage {
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:FRAME(SizeWidth(30), SizeHeight(70), kScreenW - SizeWidth(60), SizeHeight(207))];
        _logoImage.backgroundColor = [UIColor clearColor];
        _logoImage.image = [UIImage imageNamed:@"logo"];
    }
    return _logoImage;
}

- (void)addimage {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takeAlbum];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //TODO
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:cancelAction];
    
    [self.navigationController presentViewController:actionSheet animated:YES completion:nil];
    
//     UIView *backView = [[UIApplication sharedApplication].keyWindow.subviews.lastObject subviews][0];
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:FRAME(15, 30, kScreenW - 30, 150)];
//    imageview.backgroundColor = [UIColor clearColor];
//    imageview.image = [UIImage imageNamed:@"logo"];
//    [backView addSubview:imageview];
    
}

- (UIButton *)man {
    if (!_man) {
        _man = [[UIButton alloc] initWithFrame:FRAME(kScreenW/2 + SizeWidth(40), 0, SizeWidth(50), SizeHeight(25))];
        [_man setTitle:@"先生" forState:UIControlStateNormal];
        _man.selected = YES;
        _man.tag = 100;
        _man.titleLabel.font = [UIFont systemFontOfSize:13];
        [_man addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_man setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_man setImage:[UIImage imageNamed:@"icon_xz"] forState:UIControlStateNormal];
        [_man setImage:[UIImage imageNamed:@"icon_xz_pre"] forState:UIControlStateSelected];
    }
    return _man;
}
- (UIButton *)womam {
    if (!_womam) {
        _womam = [[UIButton alloc] initWithFrame:FRAME(self.man.right + SizeWidth(5), 0, SizeWidth(50), SizeHeight(25))];
        [_womam setTitle:@"女士" forState:UIControlStateNormal];
        _womam.tag = 101;
        _womam.titleLabel.font = [UIFont systemFontOfSize:13];
        [_womam addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_womam setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_womam setImage:[UIImage imageNamed:@"icon_xz"] forState:UIControlStateNormal];
        [_womam setImage:[UIImage imageNamed:@"icon_xz_pre"] forState:UIControlStateSelected];
    }
    return _womam;
}

- (void)click:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = !sender.selected;
        if (sender.tag == 100) {
            self.womam.selected = NO;
            isman = YES;
            self.model.man = YES;
        }else {
            self.man.selected = NO;
            isman = NO;
            self.model.man = NO;
        }
    }
   
}


@end
