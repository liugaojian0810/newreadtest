//
//  HFInteractiveStatusListViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractiveStatusListViewController.h"
#import "HFInteractiveStatusListHeaderView.h"
#import "HFInteractiveStatusTableViewCell.h"
#import "HFImmediatelyOrderTableViewCell.h"
#import <JKCategories/JKCategories.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "HFInteractiveViewModel.h"
#import "HUFMyNoReservedCourseListModel.h"
//#import "HFLiveBroadcastControllerO.h"
#import <YSSDK/YSSDKManager.h>
#import "UIDevice+HFDevice.h"

@interface HFInteractiveStatusListViewController ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource, YSSDKDelegate>
@property (weak, nonatomic) IBOutlet UITableView *statusTableView;
@property (nonatomic, strong)HFInteractiveStatusListHeaderView *headerView;
@property (nonatomic, assign)NSInteger status;//两种状态
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArr;
@property (nonatomic, strong)HUFMyNoReservedCourseListModel *dotModel;//未预约模型
@property (nonatomic, strong)HFAMyReservedCourseListModel *reserveModel;//已预约模型
@property (nonatomic, strong)NSString *serverDateString;//系统时间字符串
@property (nonatomic, weak) YSSDKManager *ysSDKManager;
@property (nonatomic, strong)UIImage *nullImage;
@property (nonatomic, strong)NSString *nullString;
@end

@implementation HFInteractiveStatusListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIDevice setHScreen];
    self.ysSDKManager = [YSSDKManager sharedInstance];
    [self.ysSDKManager registerManagerDelegate:self];
    
    self.titleName = @"互动营";
    self.statusTableView.delegate = self;
    self.statusTableView.dataSource = self;
    [self.statusTableView registerNib:[UINib nibWithNibName:@"HFInteractiveStatusTableViewCell" bundle:nil] forCellReuseIdentifier:@"interactiveCell"];
    [self.statusTableView registerNib:[UINib nibWithNibName:@"HFImmediatelyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"orderCell"];
    [self updateTableViewData:0];

    //获取系统时间
    NSDate *date = [HFCountDown getServerTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    self.serverDateString = [dateFormatter stringFromDate:date];
}

- (void)reloadNullView:(NSInteger)status {
    self.statusTableView.emptyDataSetSource = self;
    self.statusTableView.emptyDataSetDelegate = self;
    if (status == 0) {
        self.nullImage = [UIImage imageNamed:@"qs-zanwuwangl"];
        self.nullString = @"当前网络不可用，请检查网络配置～";
    } else {
        self.nullImage = [UIImage imageNamed:@"qs-zanwushuju"];
        self.nullString = @"当前页面暂无数据哦～";
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    for (UIButton *btn in self.btnArr) {
        if (sender.tag == btn.tag) {
            btn.selected = YES;
            btn.titleLabel.font = [UIFont fontWithName:@"ARYuanGB-BD" size:14];
        } else {
            btn.selected = NO;
            btn.titleLabel.font = [UIFont fontWithName:@"ARYuanGB-MD" size:14];
        }
    }
    self.status = sender.tag;
    [self updateTableViewData:sender.tag];
}

- (void)updateTableViewData:(NSInteger)status {
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    if (nil == babyID) {
        return;
    }
    if (status == 0) {
        
        [Service postWithUrl:GetMyReservedCourseAPI params:@{@"id": babyID} success:^(NSDictionary *responseObject) {
            NSError *error;
            [self reloadNullView:1];
            self.reserveModel = nil;
            self.reserveModel = [HFAMyReservedCourseListModel fromJSON:[responseObject jk_JSONString] encoding:4 error:&error];
            [self.statusTableView reloadData];

        } failure:^(HFError *error) {
            if ([error.errorMessage isEqualToString:@"网络连接失败"]) {
                [self reloadNullView:0];
            }else {
                [self reloadNullView:1];
            }
            self.reserveModel = nil;
            [self.statusTableView reloadData];

        }];
    } else {
        [Service postWithUrl:SubscribeListAPI params:@{@"id": babyID} success:^(NSDictionary *responseObject) {
            NSError *error;
            [self reloadNullView:1];

            self.dotModel = nil;
            self.dotModel = [HUFMyNoReservedCourseListModel fromJSON:[responseObject jk_JSONString] encoding:4 error:&error];
            [self.statusTableView reloadData];
        } failure:^(HFError *error) {
            if ([error.errorMessage isEqualToString:@"网络连接失败"]) {
                [self reloadNullView:0];
            }else {
                [self reloadNullView:1];
            }
            self.dotModel = nil;
            [self.statusTableView reloadData];
        }];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.status == 0) {
        HFAModel *model = self.reserveModel.model[section];
        return model.lists.count;
    } else {
        HUFModel *model = self.dotModel.model[section];
        return model.lists.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.status == 0) {
      return self.reserveModel.model.count;
    } else {
        return self.dotModel.model.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.status == 1) {
        HUFModel *model = self.dotModel.model[indexPath.section];
        HUFList *modelList = model.lists[indexPath.row];
        return 90+ 38 *(modelList.teachers.count - 1);
    } else {
        return 100;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak HFInteractiveStatusListViewController *weakSelf = self;
    if (self.status == 1) {
        HFImmediatelyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell" forIndexPath:indexPath];
        HUFModel *model = self.dotModel.model[indexPath.section];
        HUFList *modelList = model.lists[indexPath.row];
        [cell updateSubViewswith:modelList.teachers.count model:modelList];
        NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;

        cell.block = ^(NSInteger ID) {
            [Service postWithUrl:SubscribeAPI params: @{@"childId":babyID,@"appointmentIntervalId":@(ID)} success:^(id responseObject) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showMessage:@"您已成功预约，请准时参加互动"];
                });
                [weakSelf updateTableViewData:1];
            } failure:^(HFError *error) {
                [weakSelf updateTableViewData:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showMessage:@"预约失败"];
                });
            }];
        };
        return cell;
    } else {
        HFInteractiveStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"interactiveCell" forIndexPath:indexPath];
        HFAModel *model = self.reserveModel.model[indexPath.section];
        HFAList *rowModel = model.lists[indexPath.row];
        //视频是否已经开始
        if ([HFCountDown getDateDifferenceHHmmWithNowDateStr:rowModel.startTime deadlineStr:self.serverDateString] > -600) {
            [cell.backBtn setTitle:@"去互动" forState:UIControlStateNormal];
            [cell.backBtn setBackgroundImage:[UIImage imageNamed:@"btn-order"] forState:UIControlStateNormal];
        } else {
            [cell.backBtn setTitle:@"取消" forState:UIControlStateNormal];
            [cell.backBtn setBackgroundImage:[UIImage imageNamed:@"base_confirm_btn"] forState:UIControlStateNormal];
        }
        cell.ReservedCourseModel = rowModel;
        cell.cancelBlock = ^(NSInteger classId) {
            //视频是否已经开始
            if ([HFCountDown getDateDifferenceHHmmWithNowDateStr:rowModel.startTime deadlineStr:self.serverDateString] > -600) {
                [UIDevice setVScreen];
                __weak __typeof(self) weakSelf = self;
                [weakSelf.ysSDKManager joinRoomWithRoomId: rowModel.roomNo nickName: [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyName roomPassword:nil userRole: YSSDKSUserType_Student userId:nil userParams:nil];
                
            } else {
                [Service postWithUrl:CancelSubscribeAPI params:@{@"id":@(rowModel.hfAppointmentChildenId)} success:^(NSDictionary *responseObject) {

                    [weakSelf updateTableViewData:0];
                    [weakSelf updateTableViewData:weakSelf.status];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD showMessage:@"取消预约成功"];
                    });
                    
                } failure:^(HFError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [MBProgressHUD showMessage:@"取消预约失败"];
                        });
                    });
                    [weakSelf updateTableViewData:0];
                }];
            }
        };

        return cell;
    }
}

- (void)onRoomConnectionLost {
    [UIDevice setHScreen];
}

-(void)onRoomLeft {
    [UIDevice setHScreen];
}

-(void)onRoomKickedOut:(NSDictionary *)reason {
    [UIDevice setHScreen];
}
-(void)onRoomReportFail:(YSSDKErrorCode)errorCode descript:(NSString *)descript {
    [UIDevice setHScreen];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HFInteractiveStatusListHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"HFInteractiveStatusListHeaderView" owner:nil options:nil].firstObject;
    if (self.status == 0) {
        HFAModel *model = self.reserveModel.model[section];
        header.reservedModel = model;
    }  else {
        HUFModel *model = self.dotModel.model[section];
        header.noReservedModel = model;
    }
    return header;
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.nullString;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new]; paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter; NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithName:@"ARYuanGB-BD" size:12.0f], NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#D4A171"], NSParagraphStyleAttributeName:paragraph };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -3;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.nullImage;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}


@end
