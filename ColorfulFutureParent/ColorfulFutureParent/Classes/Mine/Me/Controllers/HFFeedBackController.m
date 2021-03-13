//
//  HFFeedBackController.m
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFFeedBackController.h"
#import "HFFeedbackCollectionViewCell.h"
#import "HFSelectImageTool.h"
#import "ColorfulFutureParent-Swift.h"

@interface HFFeedBackController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UILabel *wordNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *placehouderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong)NSMutableArray *imgs;
@property (nonatomic, strong)HFSelectImageTool * selectPhotoTool;
@property (nonatomic, strong)HFSetupViewModel *myViewModel;

@end

@implementation HFFeedBackController

HFArray(imgs)

- (HFSelectImageTool *)selectPhotoTool{
    // 否则弹出照片选择器之后就被销毁了
    if (_selectPhotoTool == nil) {
        _selectPhotoTool = [[HFSelectImageTool alloc] init];
    }
    return _selectPhotoTool;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myViewModel = [[HFSetupViewModel alloc]init];
    self.title = @"问题反馈";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((HFCREEN_WIDTH - 135)/3.0, (HFCREEN_WIDTH - 135)/3.0);
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HFFeedbackCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HFFeedbackCollectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    WS(weakSelf);
    [[[weakSelf.textView rac_textSignal] filter:^BOOL(NSString *value) {
        if (value.length > 0) {
            weakSelf.placehouderLabel.text = @"";
            weakSelf.loginBtn.enabled = YES;
            weakSelf.loginBtn.alpha = 1;
        }else{
            weakSelf.placehouderLabel.text = @"请描述您的问题";
            weakSelf.loginBtn.enabled = NO;
            weakSelf.loginBtn.alpha = 0.39;
        }
        return value.length > 0;
    }] subscribeNext:^(NSString *x){
        if (x.length > 200) {
            weakSelf.textView.text = [x substringToIndex:200];
        }
        weakSelf.wordNumberLabel.text = [NSString stringWithFormat:@"%ld/%ld",weakSelf.textView.text.length, 200 - weakSelf.textView.text.length];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.imgs.count >= 3) {
        return 3;
    } else {
        return self.imgs.count + 1;
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HFFeedbackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HFFeedbackCollectionViewCell" forIndexPath:indexPath];
    if (self.imgs.count > 3) {
        cell.imgView.hidden = NO;
        cell.imgView.image = self.imgs[indexPath.row];
        cell.closeBtn.hidden = NO;
    }else{
        if (self.imgs.count == indexPath.row) {
            cell.closeBtn.hidden = YES;
            cell.imgView.image = [UIImage imageNamed:@"wtfk_img_shagnchuan"];
        } else {
            cell.imgView.hidden = NO;
            cell.imgView.image = self.imgs[indexPath.row];
            cell.closeBtn.hidden = NO;
        }
    }
    WeakSelf
    cell.deleteBlock = ^{
        Strong_Self
        [self.imgs removeObjectAtIndex:indexPath.row];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    };
    return cell;;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.imgs.count < 3 && self.imgs.count == indexPath.row) {
        [self selectPhotoTool];
        WS(weakSelf);
        [self.selectPhotoTool selectSinglePhotoFromController:self complete:^(UIImage *image) {
            [weakSelf.imgs addObject:image];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
            });
        }];
    }
}

- (IBAction)selectType:(UIButton *)sender {
    if (sender.tag == 101) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
    }else{
        self.rightBtn.selected = YES;
        self.leftBtn.selected = NO;
    }
}


- (IBAction)submitAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    [ShowHUD showHUDLoading];
    if (self.imgs.count != 0 && self.myViewModel.imagesModel == nil) {
        WS(weakSelf);
        [HFPubRequest uploadImageWithImages:self.imgs uploadProgress:^(double progress) {
        } successed:^(NSArray<HFImageUploadResultModel *> * _Nonnull res) {
            weakSelf.myViewModel.imagesModel = res;
            [weakSelf submit];
        } failured:^(NSError * _Nonnull error) {
            [ShowHUD hiddenHUDLoading];
        }];
    }else{
        [self submit];
    }
}

- (void)submit{
    self.myViewModel.pbContent = self.textView.text;
    WeakSelf
    [self.myViewModel feedback:^{
        Strong_Self
        [ShowHUD hiddenHUDLoading];
        [HFAlert showAlertWithMsg:@"提交成功" inController:self alertStatus:AlertStatusSuccfess completeBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } :^{
        Strong_Self
        [ShowHUD hiddenHUDLoading];
        [HFAlert showAlertWithMsg:@"提交失败" inController:self alertStatus:AlertStatusSuccfess];
    }];
}

@end
