//
//  HFHintViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFHintViewController.h"
#import "HFClasssForeshowView.h"
#import "HFCourseForeshowModel.h"
#import "HFPlayBackViewController.h"
#import "HFPareScheduleController.h"
#import "HFPosterListController.h"
#import "HFLessonDetailModel.h"
#import "ColorfulFutureParent-Swift.h"

@interface HFHintViewController ()
@property (weak, nonatomic) IBOutlet UILabel *massageLab;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *hintBackView;
@property (weak, nonatomic) IBOutlet UIView *backBtnView;
@property (nonatomic, strong) HFClasssForeshowView *foreshowView;
@property (weak, nonatomic) IBOutlet UIButton *playBackBtn;
@property (weak, nonatomic) IBOutlet UIButton *lookScheduleBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

- (IBAction)playBack:(id)sender;
- (IBAction)lookSchedule:(id)sender;

@end

@implementation HFHintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.massageLab.text = self.massageString;
    self.hiddenAllView = YES;
    self.hiddenCloseBtn = YES;
    self.titleLabel.text = self.titleString;
    if ([self.titleString isEqualToString:@"关卡预告"]) {
        self.foreshowView = [[NSBundle mainBundle]loadNibNamed:@"HFClasssForeshowView" owner:nil options:nil].firstObject;
        self.foreshowView.frame = CGRectMake(0, 0, 325, 145);
        self.hintBackView.hidden = NO;
        [self.hintBackView addSubview:self.foreshowView];
        if (self.model.startDate.length > 0) {
            self.foreshowView.model = self.model;
        } else {
            self.foreshowView.nullView.hidden = NO;
        }
        self.backBtnView.hidden = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
}
- (IBAction)dismisAcrtion:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (self.block) {
        self.block();
    }
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    self.massageLab.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}
//课表
- (IBAction)lookSchedule:(id)sender {
    HFPareScheduleController *schedule = [HFPareScheduleController new];
    [self presentViewController:schedule animated:NO completion:nil];
}
//回放
- (IBAction)playBack:(id)sender {
    HFPlayBackVideoViewController * pbv = [HFPlayBackVideoViewController new];
    [self presentViewController:pbv animated:NO completion:nil];
}
//分享
- (IBAction)shareAction:(UIButton *)sender {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    HFUserInfo *userInfo = [[HFUserManager sharedHFUserManager] getUserInfo];

    [param setValue:SafeParamStr(userInfo.userId) forKey:@"userId"];
    [param setValue:SafeParamStr(userInfo.babyInfo.babyID) forKey:@"ownerId"];
    [param setValue:@0 forKey:@"clientType"];// 端类型:0 家长 1 教师 2 园长
    [param setValue:@1 forKey:@"goodsId"];
    [param setValue:@2 forKey:@"earningsSource"];
    [ShowHUD showHUDLoading];
    [Service postWithUrl:CloudHomeDetailAPI params:param success:^(id responseObject) {
        [ShowHUD hiddenHUDLoading];
        NSDictionary *dataDic = [responseObject objectForKey:@"model"];
        HFLessonDetailModel *detailModel = [HFLessonDetailModel mj_objectWithKeyValues:dataDic];
        HFPosterListController * poster = [[HFPosterListController alloc] init];
        poster.fromeType = FRIEND;
        poster.detailModel = detailModel;
        [self presentViewController:poster animated:YES completion:nil];    } failure:^(HFError *error) {
        [ShowHUD hiddenHUDLoading];

    }];

    
}

- (void)setDataWithSource {
    
}
@end
