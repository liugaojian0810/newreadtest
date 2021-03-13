//
//  HFPlayBackViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPlayBackViewController.h"
#import "HFInteractiveStatusListHeaderView.h"
#import "HFInteractiveStatusTableViewCell.h"
#import "HFCoursePlaybackListModel.h"
#import "HFVideoController.h"
#import "HUIClassPlayBackModel.h"
#import "HFClassVideoURLModel.h"
#import <JKCategories/JKCategories.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface HFPlayBackViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong)HFCoursePlaybackListModel *dataModel;
@property (nonatomic, strong)HUIClassPlayBackModel *backModel;
@property (nonatomic, strong)UIImage *nullImage;
@property (nonatomic, strong)NSString *nullString;
@end

@implementation HFPlayBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"成长营冲关回放";
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerNib:[UINib nibWithNibName:@"HFInteractiveStatusTableViewCell" bundle:nil] forCellReuseIdentifier:@"interactiveCell"];
    
    WeakSelf
    [self.tableview headerRefreshingBlock:^(NSInteger page) {
        Strong_Self
        [self requestDataSource];
    }];
    [self.tableview.mj_header beginRefreshing];
}

-(void)requestDataSource{
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [Service postWithUrl:GetCoursePlaybackAPI params:@{@"id": babyID} success:^(NSDictionary *responseObject) {
        NSError *error;
        [self.tableview.mj_header endRefreshing];
        [self reloadNullView:1];
        self.backModel = [HUIClassPlayBackModel fromJSON:[responseObject jk_JSONString] encoding:4 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
        [self.tableview reloadData];
    } failure:^(HFError *error) {
        [self.tableview.mj_header endRefreshing];
        if ([error.errorMessage isEqualToString:@"网络连接失败"]) {
            [self reloadNullView:0];
        } else {
            [self reloadNullView:1];
        }
        self.dataModel = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
    }];
}


- (void)reloadNullView:(NSInteger)status {
    self.tableview.emptyDataSetSource = self;
    self.tableview.emptyDataSetDelegate = self;
    if (status == 0) {
        self.nullImage = [UIImage imageNamed:@"qs-zanwuwangl"];
        self.nullString = @"当前网络不可用，请检查网络配置～";
    } else {
        self.nullImage = [UIImage imageNamed:@"qs-zanwushuju"];
        self.nullString = @"当前页面暂无数据哦～";
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HUIModel *model = self.backModel.model[section];
    
    return model.lists.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.backModel.model.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak HFPlayBackViewController *weakSelf = self;
    HFInteractiveStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"interactiveCell" forIndexPath:indexPath];
    HUIModel *model = self.backModel.model[indexPath.section];
//    NSString *courseId = model.lists[indexPath.row].courseURL;
    HUIList *rowModel = model.lists[indexPath.row];
    cell.backModel = rowModel;
    cell.bottomLabel.text = [NSString stringWithFormat:@"预约情况：%@/%@",rowModel.number,rowModel.numberMax];
    cell.cancelBlock = ^(NSInteger classId) {
        NSString *babyId = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
        [ShowHUD showHUDLoading];
        [Service postWithUrl:PlayVideoAPI params:@{@"videoId":rowModel.courseURL, @"babyId": babyId} success:^(id responseObject) {
            [ShowHUD hiddenHUDLoading];
            // 回放
            HFVideoController *video = [HFVideoController new];
            NSError *error;
            HFClassVideoURLModel *model = [HFClassVideoURLModel fromJSON:[responseObject valueForKey:@"model"] encoding:4 error:&error];
            video.url = model.data.videoURL.lastObject.originURL;
            video.courseId = [NSString stringWithFormat:@"%ld", (long)rowModel.identifier];
            video.titleText = rowModel.courseName;
            video.weekDetailId = [NSString stringWithFormat:@"%ld", rowModel.weekDetailId];
            [weakSelf presentViewController:video animated:NO completion:nil];
        } failure:^(HFError *error) {
            [ShowHUD hiddenHUDLoading];
            [MBProgressHUD showMessage:@"获取视频路径失败"];
        }];
    };
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HFInteractiveStatusListHeaderView *header = [[NSBundle mainBundle]loadNibNamed:@"HFInteractiveStatusListHeaderView" owner:nil options:nil].firstObject;
    HUIModel *model = self.backModel.model[section];
    header.des.text = [model.appointmentDate substringWithRange:NSMakeRange(0, 10)];
    return header;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.nullString;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new]; paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter; NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithName:@"ARYuanGB-BD" size:12.0f], NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#D4A171"], NSParagraphStyleAttributeName:paragraph };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 5;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.nullImage;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

@end
