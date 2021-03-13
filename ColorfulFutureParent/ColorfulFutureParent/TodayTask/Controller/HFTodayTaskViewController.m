//
//  HFTodayTaskViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFTodayTaskViewController.h"
#import "HFTodayTaskTableViewCell.h"
#import "HFTodayTaskListModel.h"
#import "UIView+HFCornerRadius.h"
#import "HFVideoController.h"
#import "HFCountDown.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <YSSDK/YSSDKManager.h>
#import "UIDevice+HFDevice.h"
#import "HFClassVideoURLModel.h"
#import "UIScrollView+HFRefrash.h"
@interface HFTodayTaskViewController ()<UITableViewDelegate, UITableViewDataSource,YSSDKDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *btnBackView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonArr;
@property (nonatomic, assign)NSInteger status;//0为成长营1为互动营暂时用不到
@property (nonatomic, strong)HFTodayTaskListModel *dataModel;
@property (nonatomic, strong)NSString *serverDateString;//系统时间字符串
@property (nonatomic, weak) YSSDKManager *ysSDKManager;
@property (strong , nonatomic) NSTimer *timer;
@property (assign , nonatomic) BOOL index;
@property (weak, nonatomic) IBOutlet UIImageView *noContentImageView;
@property (weak, nonatomic) IBOutlet UILabel *noContentLabel;

@end

@implementation HFTodayTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ysSDKManager = [YSSDKManager sharedInstance];
    [self.ysSDKManager registerManagerDelegate:self];
    self.titleName = @"今日任务";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HFTodayTaskTableViewCell" bundle:nil] forCellReuseIdentifier:@"todayCell"];
    [self.btnBackView setCorner:UIRectCornerTopLeft|UIRectCornerTopRight withRadius:4];
    self.index = 0;
    WeakSelf
    [self.tableView headerRefreshingBlock:^(NSInteger page) {
        Strong_Self
        [self reloadTableViewWith:self.index];
    }];
    [self.tableView.mj_header beginRefreshing];
    //获取系统年月日
    NSDate *date = [HFCountDown getServerTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.serverDateString = [dateFormatter stringFromDate:date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calTime) userInfo:nil repeats:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calTime) userInfo:nil repeats:YES];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if(_timer)
    {
        _timer = nil;//关闭定时器，
    }
}

//定时器刷新倒计时
-(void)calTime
{
    NSArray  *cells = _tableView.visibleCells; //取出屏幕可见ceLl
    for (HFTodayTaskTableViewCell *cell in cells) {
        HFTodayTaskListModelElement *rowData = self.dataModel.model[cell.tag];
        NSString *timeString =[self getTimeStr: [NSString stringWithFormat:@"%@ %@:00",self.serverDateString, rowData.startDate]];
        //判断按钮状态
        if (self.status == 0) {
            if ([timeString localizedStandardContainsString :@"-"]) {
                [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cell.button setTitle:@"去互动" forState:UIControlStateNormal];
                [cell.button setBackgroundImage:[UIImage imageNamed:@"btn-order"] forState:UIControlStateNormal];
                cell.button.userInteractionEnabled = YES;
            } else {
                 [cell.button setTitleColor:[UIColor jk_colorWithHexString:@"#D4A171"] forState:UIControlStateNormal];
                [cell.button setTitle:timeString forState:UIControlStateNormal];
                [cell.button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                cell.button.userInteractionEnabled = NO;
            }
        }
    }
}
//返回倒计时
-(NSString *)getTimeStr:(NSString *)fireStr
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* fireDate = [formater dateFromString:fireStr];
    NSDate *today = [HFCountDown getServerTime];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    long hour = [d day] *24 + [d hour];
    NSString *seconds;
    NSString *minutes;
    NSString *hours;
    if([d second]<10)
        seconds = [NSString stringWithFormat:@"0%ld",(long)[d second]];
    else
        seconds = [NSString stringWithFormat:@"%ld",(long)[d second]];
    if([d minute]<10)
        minutes = [NSString stringWithFormat:@"0%ld",(long)[d minute]];
    else
        minutes = [NSString stringWithFormat:@"%ld",(long)[d minute]];
    if(hour < 10)
        hours = [NSString stringWithFormat:@"0%ld", hour];
    else
        hours = [NSString stringWithFormat:@"%ld",hour];
    return [NSString stringWithFormat:@"%@:%@:%@", hours, minutes,seconds];
}

- (void)reloadNullView:(NSInteger)status {
    if (status == 0) {
        self.noContentImageView.image = [UIImage imageNamed:@"qs-zanwuwangl"];
        self.noContentLabel.text = @"当前网络不可用，请检查网络配置～";
    } else {
        self.noContentImageView.image = [UIImage imageNamed:@"qs-zanwushuju"];
        self.noContentLabel.text = @"当前页面暂无数据哦～";
    }
}

//刷新数据
- (void)reloadTableViewWith:(NSInteger)status {
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    if (status == 0) {
        [Service postWithUrl:alreadyCourceAPI params:@{@"babyId": babyID, @"campTypeId":@(0)} success:^(NSDictionary *responseObject) {
            [self.tableView.mj_header endRefreshing];
            NSError *error = nil;
            self.dataModel = nil;
            self.dataModel = [HFTodayTaskListModel fromJSON:[responseObject jk_JSONString] encoding:4 error:&error];
            [self reloadNullView:1];
            [self setNoContentStatus];
            [self.tableView reloadData];
        } failure:^(HFError *error) {
            [self.tableView.mj_header endRefreshing];
            if ([error.errorMessage isEqualToString:@"网络连接失败"]) {
                [self reloadNullView:0];
            } else {
                [self reloadNullView:1];
            }
            self.dataModel = nil;
            [self setNoContentStatus];
            [self.tableView reloadData];
        }];
    } else {
        [Service postWithUrl:currentCourceDtoAPI params:@{@"babyId": babyID,@"campTypeId":@(0)} success:^(NSDictionary *responseObject) {
            [self.tableView.mj_header endRefreshing];
            NSError *error = nil;
            self.dataModel = nil;
            self.dataModel = [HFTodayTaskListModel fromJSON:[responseObject jk_JSONString] encoding:4 error:&error];
            [self reloadNullView:1];
            [self setNoContentStatus];
            [self.tableView reloadData];
        } failure:^(HFError *error) {
            [self.tableView.mj_header endRefreshing];
            if ([error.errorMessage isEqualToString:@"网络连接失败"]) {
                [self reloadNullView:0];
            } else {
                [self reloadNullView:1];
            }
            self.dataModel = nil;
            [self setNoContentStatus];
            [self.tableView reloadData];
        }];
    }
}

-(void)setNoContentStatus{
    if (self.dataModel.model.count == 0) {
        self.noContentLabel.hidden = NO;
        self.noContentImageView.hidden = NO;
    }else{
        self.noContentLabel.hidden = YES;
        self.noContentImageView.hidden = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModel.model.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HFTodayTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todayCell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    HFTodayTaskListModelElement *rowData = self.dataModel.model[indexPath.row];
    cell.model = rowData;

    cell.button.hidden = NO;
    if (self.status == 0) {
            //视频是否已开启
        cell.date.text = [NSString stringWithFormat:@"%@-%@",rowData.startDate,rowData.endDate];
        NSString *timeString =[self getTimeStr: [NSString stringWithFormat:@"%@ %@:00",self.serverDateString, rowData.startDate]];
        if ([timeString localizedStandardContainsString :@"-"]) {
            [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.button setTitle:@"去互动" forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"btn-order"] forState:UIControlStateNormal];
            cell.button.userInteractionEnabled = YES;
        } else {
            [cell.button setTitleColor:[UIColor jk_colorWithHexString:@"#D4A171"] forState:UIControlStateNormal];
            [cell.button setTitle:timeString forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            cell.button.userInteractionEnabled = NO;

        }
    } else {
        cell.date.text = [NSString stringWithFormat:@"%@-%@",rowData.startDate,rowData.endDate];
        if ([HFCountDown getDateDifferenceHHmmWithNowDateStr:rowData.startDate deadlineStr:self.serverDateString] > -600) {
            [cell.button setTitle:@"去互动" forState:UIControlStateNormal];
            [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"btn-order"] forState:UIControlStateNormal];
            cell.button.userInteractionEnabled = YES;
        } else {
            [cell.button setTitle:@"未开始" forState:UIControlStateNormal];
            [cell.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.button setBackgroundImage:[UIImage imageNamed:@"base_confirm_btn"] forState:UIControlStateNormal];
            cell.button.userInteractionEnabled = NO;
        }
    }
 
    __weak HFTodayTaskViewController *weakSelf = self;
    cell.block = ^(NSInteger classId) {
        if (weakSelf.status == 0) {
            NSString *babyId = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
            [ShowHUD showHUDLoading];
            [Service postWithUrl:PlayVideoAPI params:@{@"videoId": rowData.courseUrl, @"babyId": babyId} success:^(id responseObject) {
                [ShowHUD hiddenHUDLoading];
                [Service postWithUrl:GetGoIntoRoomStuSaveAPI params:@{@"babyId": babyId, @"courseId": [NSString stringWithFormat:@"%ld", (long)rowData.courseID]} success:nil failure:nil];
                HFVideoController *video = [HFVideoController new];
                NSError *error;
                HFClassVideoURLModel *modelTemp = [HFClassVideoURLModel fromJSON:[responseObject valueForKey:@"model"] encoding:4 error:&error];
                video.url = modelTemp.data.videoURL.lastObject.originURL;
                video.hiddenBottomBar = YES;
                video.courseId = [NSString stringWithFormat:@"%ld", (long)rowData.courseID];
                video.titleText = rowData.courceName;
                video.classStartTime = rowData.startDate;
                video.weekDetailId = [NSString stringWithFormat:@"%ld", (long)rowData.weekDetailId];
                [self presentViewController:video animated:NO completion:nil];
            } failure:^(HFError *error) {
                [ShowHUD hiddenHUDLoading];
                [MBProgressHUD showMessage:@"获取视频路径失败"];
            }];
        } else {
            [UIDevice setVScreen];
            __weak __typeof(self) weakSelf = self;
            [weakSelf.ysSDKManager joinRoomWithRoomId: rowData.roomNo nickName: [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyName roomPassword:nil userRole:  YSSDKSUserType_Student userId:nil userParams:nil];
        }
    };
    return cell;
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

- (IBAction)btnAction:(UIButton *)sender {
    for (UIButton *btn in self.buttonArr) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
        self.status = sender.tag;
        
        self.index = sender.tag;
        [self.tableView.mj_header beginRefreshing];
//        [self reloadTableViewWith:sender.tag];
    }
}

@end
