//
//  HFPayHistoryViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPayHistoryViewController.h"
#import "HFHistoryTableViewCell.h"
#import "HFHistoryHeaderView.h"
#import "HFHistoryFooderView.h"
#import "HFPayTheFeesHistoryListModel.h"
#import "NSMutableAttributedString+HFAttributedString.h"
#import "UIView+Extension.h"

@interface HFPayHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *nullImageView;
@property (nonatomic, strong)NSMutableArray <HFPayTheFeesHistoryModel *>*dataArr;


@end

@implementation HFPayHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"HFHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"historyCell"];
    self.tableView.rowHeight = 80;
    [self updateLeftBtnImgWithName:@"icon-fanhui"];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [params setValue:babyID forKey:@"childId"];
    [params setValue:[HFUserManager sharedHFUserManager].getUserInfo.userId forKey:@"parentId"];
    [Service postWithUrl:GetHistoryRecordsURLAPI params:params success:^(id responseObject) {
        NSError *error;
        HFPayTheFeesHistoryListModel *tempModel = [HFPayTheFeesHistoryListModel fromJSON:[responseObject jk_JSONString] encoding:4 error: &error];
        HFLog(@"tempModel:%@",tempModel);
        self.dataArr = [tempModel.model mutableCopy];
        HFLog(@"self.dataArr.count:%lu",(unsigned long)self.dataArr.count);
        [self.tableView reloadData];
        self.nullImageView.hidden = self.dataArr.count;
    } failure:^(HFError *error) {
        [MBProgressHUD showMessage:error.errorMessage];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HFPayTheFeesHistoryModel *model = self.dataArr[section];
    if (model.paymentInfoVOList.count < 4) {
        return model.paymentInfoVOList.count;
    } else {
        return model.isSelect ? model.paymentInfoVOList.count : 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HFHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
    cell.rowModel = self.dataArr[indexPath.section].paymentInfoVOList[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HFHistoryHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"HFHistoryHeaderView" owner:nil options:nil].firstObject;
    HFPayTheFeesHistoryModel *sectionModel = self.dataArr[section];
    if (sectionModel.type == 1) {
        headerView.allNumber.text = [NSString stringWithFormat:@"共%ld项",(long)sectionModel.total];
        headerView.allNumber.textColor = [UIColor jk_colorWithHexString:@"#454545"];
        headerView.allNumber.backgroundColor = [UIColor jk_colorWithHexString:@"F5F5F5"];
        NSString *money = [NSString stringWithFormat:@"¥%.2lf",sectionModel.totalAmount *0.01];
        NSString *money1 = [NSString stringWithFormat:@"¥%.2lf",sectionModel.couponAmount *0.01];
        NSString *money2 = [NSString stringWithFormat:@"¥%.2lf",sectionModel.payAmount *0.01];
        NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：%@（已抵扣：%@ 实缴：%@）",money,money1,money2]];
        headerView.nowPrice.attributedText = [[price attributedStringwith:[UIColor jk_colorWithHexString:@"51A9FF"] whith:ARYuanbold(15) with:NSMakeRange(3 + money.length + 5, money1.length)] attributedStringwith:[UIColor jk_colorWithHexString:@"#E02020"] whith:ARYuanbold(15) with:NSMakeRange(price.length - money2.length - 1, money2.length)];
    } else {
        headerView.allNumber.text = @"  线下退费  ";
        headerView.allNumber.textColor = [UIColor whiteColor];
        headerView.allNumber.backgroundColor = [UIColor jk_colorWithHexString:@"#51A9FF"];
        headerView.allNumber.layer.cornerRadius = 5;
        headerView.allNumber.layer.masksToBounds = YES;
        NSString *money = [NSString stringWithFormat:@"退费：¥%.2lf",sectionModel.money *0.01];
        headerView.nowPrice.attributedText = [money stringwith:[UIColor jk_colorWithHexString:@"51A9FF"] whith:ARYuanbold(15) with:NSMakeRange(3, money.length - 3)];
    }
    headerView.time.text = sectionModel.paymentTime;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    HFHistoryFooderView *fooderView = [[NSBundle mainBundle]loadNibNamed:@"HFHistoryFooderView" owner:nil options:nil].firstObject;
    fooderView.fooderBtn.tag = section;
    HFPayTheFeesHistoryModel *sectionModel = self.dataArr[section];
    if (sectionModel.isSelect) {
        [fooderView.fooderBtn setTitle:@"收起" forState:UIControlStateNormal];
        [fooderView.fooderBtn setImage:[UIImage imageNamed:@"payTheFeesHistory_top"] forState:UIControlStateNormal];
    } else {
        [fooderView.fooderBtn setTitle:@"展开更多" forState:UIControlStateNormal];
        [fooderView.fooderBtn setImage:[UIImage imageNamed:@"payTheFeesHistory_bommt"] forState:UIControlStateNormal];
    }
    WS(weakSelf);
    fooderView.block = ^(NSInteger section) {
        HFPayTheFeesHistoryModel *dic = weakSelf.dataArr[section];
        dic.isSelect = !dic.isSelect;
        [weakSelf.dataArr replaceObjectAtIndex:section withObject:dic];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    };
    if (sectionModel.paymentInfoVOList.count < 4) {
        return [UIView new];
    } else {
        return fooderView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    HFPayTheFeesHistoryModel *dic = self.dataArr[section];
    if (dic.paymentInfoVOList.count < 4) {
        return 0.001;
    } else {
        return 40;
    }
}

- (NSMutableArray<HFPayTheFeesHistoryModel *> *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
