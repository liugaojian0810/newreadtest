//
//  HFLandscapeViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFAllViewController.h"
#import "HFAllNavView.h"
@interface HFAllViewController ()

@property (nonatomic, strong)HFAllNavView *headerView;

@end

@implementation HFAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView = [[NSBundle mainBundle]loadNibNamed:@"HFAllNavView" owner:nil options:nil].firstObject;
    [self.view addSubview:self.headerView];
    self.headerView.titleLabel.text = self.titleString;
    [self.headerView.backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)backAction:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    
}

- (void)rightBtnAction:(UIButton *)sender {
    if (self.rightBTBlock) {
        self.rightBTBlock();
    }
}

- (void)initRightBT:(NSString *)sender withisImage:(BOOL)image withImageName:(NSString *)string {
    self.headerView.rightBtn.hidden = NO;
    self.headerView.rightBtn.imageRect = CGRectMake(-5, 12, 15, 15);
    if (!image) {
        [self.headerView.rightBtn setTitle:sender forState:UIControlStateNormal];
    } else {
        if (sender.length > 0) {
            [self.headerView.rightBtn setTitle:sender forState:UIControlStateNormal];
            [self.headerView.rightBtn setImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        } else {
            [self.headerView.rightBtn setImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        }
    }
}


/// 更新返回按钮的图片
/// @param imgName 图片名称
-(void)updateLeftBtnImgWithName:(NSString *)imgName{
    
    [self.headerView.backBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
}

@end
