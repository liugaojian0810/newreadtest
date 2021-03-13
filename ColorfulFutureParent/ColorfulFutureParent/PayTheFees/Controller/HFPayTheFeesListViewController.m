//
//  HFPayTheFeesListViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPayTheFeesListViewController.h"
#import "HFPayTheFeesTableViewCell.h"
#import "HFPayHistoryViewController.h"
#import "HFPayTheFeesListModel.h"
#import "HFPayTheFeesHintViewController.h"
#import "NSString+RichString.h"
#import "HFBuyLessonWebController.h"
#import <JKCategories/JKCategories.h>

@interface HFPayTheFeesListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *payBackView;
@property (weak, nonatomic) IBOutlet UIButton *allselectBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *allPrice;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *balanceAmount;
@property (weak, nonatomic) IBOutlet UIImageView *nullImage;
@property (nonatomic, strong)HFPayTheFeesListModel *dataModel;
@property (nonatomic, assign) CGFloat totalMoney;
@property (nonatomic, strong) NSArray *theFeesIDs;
@property (weak, nonatomic) IBOutlet UIImageView *nullImageView;
@property (nonatomic, assign) double price;

@end

@implementation HFPayTheFeesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"HFPayTheFeesTableViewCell" bundle:nil] forCellReuseIdentifier:@"payTheFeesCell"];
    [self initRightBT:@"历史记录" withisImage:YES withImageName:@"icon-lishijilv"];//右侧按钮
    [self updateLeftBtnImgWithName:@"icon-fanhui"];
    self.payBackView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.payBackView.layer.shadowOffset = CGSizeMake(0, -1);
    self.payBackView.layer.shadowOpacity = 0.1;
    WS(weakSelf);
    self.rightBTBlock = ^{
        HFPayHistoryViewController *VC = [HFPayHistoryViewController new];
        VC.titleString = @"历史记录";
        [weakSelf presentViewController:VC animated:NO completion:nil];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData {
    //网络请求
    [self.dataArray removeAllObjects];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [params setValue:[HFUserManager sharedHFUserManager].getUserInfo.babyInfo.kgId forKey:@"kgId"];
    [params setValue:babyID forKey:@"childId"];
    [params setValue:[HFUserManager sharedHFUserManager].getUserInfo.userId forKey:@"parentId"];
    [params setValue:@"1" forKey:@"appType"];
    [Service postWithUrl:getChildDuesListAPI params:params success:^(id responseObject) {
        self.dataModel = [HFPayTheFeesListModel mj_objectWithKeyValues:[responseObject valueForKey:@"model"]];
        for (ProjectsListModel *model in self.dataModel.projects) {
            model.isMonth = @"1";
            model.isMonth = model.payTypeList.count > 1 ? @"0" : @"1";
            model.isSelect  = NO;
            for (PayTypeListModel *subModel in model.payTypeList) {
                subModel.day = [self getTimeStr:subModel.paymentEndDate];
            }
            [self.dataArray addObject:model];
        }
        self.balanceAmount.text = [NSString stringWithFormat:@"结余：¥%.2lf",[self.dataModel.balanceAmount doubleValue]* 0.01];
        [self.tableView reloadData];
        self.nullImageView.hidden = self.dataArray.count;
        self.payBackView.hidden = !self.nullImage.hidden;
    } failure:^(HFError *error) {
        self.nullImageView.hidden = YES;
        [MBProgressHUD showMessage:error.errorMessage];
        self.payBackView.hidden = YES;
    }];
}

//计算时间
-(NSString *)getTimeStr:(NSString *)fireStr
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* fireDate = [formater dateFromString:fireStr];
    NSDate *today = [HFCountDown getServerTime];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    NSInteger month = [d month];
    NSInteger day = [d day];
    day = month * 31 + day;
    NSInteger hour = [d hour];
    return day > 0 ? [NSString stringWithFormat:@"%ld天",(long)day] : [NSString stringWithFormat:@"%ld时",(long)hour];
}

//价格计算
- (void)updateAllprice {
    NSMutableArray *priceArr = [NSMutableArray array];
    NSMutableArray *idArr = [NSMutableArray array];
    [idArr removeAllObjects];
    [priceArr removeAllObjects];
    for (ProjectsListModel *model in self.dataArray) {
        if (model.isSelect) {
            if ([model.isMonth boolValue]) {
                [priceArr addObject: @([model.payTypeList.firstObject.money doubleValue])];
                [idArr addObject:model.payTypeList.firstObject.identifier];
            } else {
                [priceArr addObject: @([model.payTypeList.lastObject.money doubleValue])];
                [idArr addObject:model.payTypeList.lastObject.identifier];
            }
        }
    }
    self.theFeesIDs = [idArr copy];
    NSNumber *sum = [priceArr valueForKeyPath:@"@sum.self"];
    self.total.text = [NSString stringWithFormat:@"应缴：¥%.2lf",[sum doubleValue] *0.01];
    self.price = [sum doubleValue]  * 0.01 - [self.dataModel.balanceAmount doubleValue]* 0.01;
    self.price = self.price > 0 ? self.price : 0.00;
    NSString *priceString = [NSString stringWithFormat:@"实缴：¥%.2f",self.price];
    self.totalMoney = [sum doubleValue];
    self.allPrice.attributedText = [priceString stringwith:[UIColor jk_colorWithHexString:@"#E02020"] whith:ARYuanbold(18) with:NSMakeRange(3, priceString.length - 3)];
    self.allselectBtn.selected = priceArr.count == self.dataArray.count;
}

- (IBAction)allSelectAction:(UIButton *)sender {
    self.allselectBtn.selected = !sender.selected;
    NSMutableArray *arr = [NSMutableArray array];
    [arr removeAllObjects];
    for (ProjectsListModel *model in self.dataArray) {
        model.isSelect = self.allselectBtn.selected;
        [arr addObject:model];
    }
    [self.dataArray removeAllObjects];
    self.dataArray = arr;
    [self.tableView reloadData];
    [self updateAllprice];
}

- (IBAction)payAction:(UIButton *)sender {
    if (self.theFeesIDs.count > 0) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:self.theFeesIDs forKey:@"list"];
        NSString *totalAmount = [NSString stringWithFormat:@"%.lf",self.totalMoney];
        [params setValue:totalAmount forKey:@"totalAmount"];
        NSString *amount = [NSString stringWithFormat:@"%.lf",self.price *100 + 0.00000000000021];
        [params setValue:amount forKey:@"amount"];
        [params setValue:[HFUserManager getUserInfo].babyInfo.babyID forKey:@"childId"];
        [params setValue:@"3" forKey:@"orderType"];
        [params setValue:[HFUserManager getUserInfo].phone forKey:@"phone"];

        [params setValue:[HFUserManager getUserInfo].babyInfo.kgId forKey:@"kgId"];
        [params setValue:[HFUserManager getUserInfo].phone forKey:@"phone"];

        [params setValue:self.dataModel.balanceAmount forKey:@"payBalance"];
        [params setValue:[HFUserManager getUserInfo].userId forKey:@"userId"];
        if (self.totalMoney > [self.dataModel.balanceAmount doubleValue]) {
            sender.userInteractionEnabled = NO;
            [Service postWithUrl:paymentOrderAPI params:params success:^(id responseObject) {
                NSDictionary *dataDic = [responseObject objectForKey:@"model"];
                [self payAtTheCashier:dataDic];
                sender.userInteractionEnabled = YES;
            } failure:^(HFError *error) {
                sender.userInteractionEnabled = YES;
                [MBProgressHUD showMessage:error.errorMessage];
            }];
        } else {
            HFPayTheFeesHintViewController *VC = [HFPayTheFeesHintViewController new];
            VC.titleString = @"支付";
            VC.dataDic = [params copy];
            [self presentViewController:VC animated:NO completion:nil];
        }
    } else {
        [MBProgressHUD showMessage:@"请选择缴费项目"];
    }
}
- (void)payAtTheCashier:(NSDictionary *)code {
    HFBuyLessonWebController *lessonVc = [[HFBuyLessonWebController alloc] init];
    lessonVc.dataDic = code;
    [self presentViewController:lessonVc animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HFPayTheFeesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payTheFeesCell" forIndexPath:indexPath];
    cell.dataModel = self.dataArray[indexPath.row];
    cell.tag = indexPath.row;
    WS(weakSelf);
    //修改左侧按钮状
    cell.selectBlock = ^(NSInteger row) {
        ProjectsListModel *model = weakSelf.dataArray[row];
        model.isSelect = !model.isSelect;
        [weakSelf.dataArray replaceObjectAtIndex:row withObject:model];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf updateAllprice];
    };
    //是否是月缴
    cell.isMonthBlock = ^(NSString *tagAndRow) {
        NSArray *dataArr = [tagAndRow componentsSeparatedByString:@"-"];
        NSInteger row = [dataArr.lastObject integerValue];
        BOOL tag = [dataArr.firstObject boolValue];
        ProjectsListModel *model = weakSelf.dataArray[row];
        model.isMonth = [NSString stringWithFormat:@"%.d", tag];
        [weakSelf.dataArray replaceObjectAtIndex:row withObject:model];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf updateAllprice];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117;
}

-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
