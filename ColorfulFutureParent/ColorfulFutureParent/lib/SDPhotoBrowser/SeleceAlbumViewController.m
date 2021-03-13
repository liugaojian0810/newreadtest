//
//  SeleceAlbumViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "SeleceAlbumViewController.h"

#import "customHeader.h"

@interface SeleceAlbumViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *firstImageArray;//第一张图
@end



@implementation SeleceAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([UserData1 userDataStandard].firstTitle != nil) {
        self.navigationItem.title = [UserData1 userDataStandard].firstTitle;
        self.title = [UserData1 userDataStandard].firstTitle;
    } else {
        self.title = @"选择相册";
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftButton)];

    _firstImageArray = [NSMutableArray array];
    if (_dataArray.count > 0) {
        BOOL firstMark = YES;
        if ([[UserData1 userDataStandard].isSeleceArray count] == 0) {
            firstMark = YES;
        } else {
            firstMark = NO;
        }
        for (NSDictionary *dic in _dataArray) {
            NSMutableArray *tempArray = [NSMutableArray array];
            if (firstMark) {
                [[UserData1 userDataStandard].isSeleceArray addObject:tempArray];
            }
            [self getAllImageArray:dic[@"assets"]];
        }
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SeleAlbumTableViewCell" bundle:nil] forCellReuseIdentifier:@"SeleAlbumTableViewCell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}
//获取所有图片
- (void)getAllImageArray:(PHFetchResult<PHAsset *> *)assets
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.networkAccessAllowed = NO;
    
    if (assets.count > 0) {
        for (int i = 0; i < assets.count; i++) {
            PHAsset *asset = assets[i];
            if (i == 0) {//只取首页图片
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(180, 180) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    [self->_firstImageArray addObject:result];
                }];
            } else {
                break;
            }
        }
    } else {
        [_firstImageArray addObject:[[UIImage alloc] init]];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     SeleAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeleAlbumTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (_dataArray.count != 0) {
        cell.rightLabel.text = _dataArray[indexPath.section][@"title"];
        cell.rightLabel2.text = [NSString stringWithFormat:@"%@张照片",_dataArray[indexPath.section][@"count"]];
        if (_firstImageArray.count != 0) {
            cell.leftImageView.image = _firstImageArray[indexPath.section];
        }
        
    }
 
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_dataArray[indexPath.section][@"count"] integerValue] > 0) {
        DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
        detailsVC.number = indexPath.section;
        detailsVC.assetArray = [_dataArray[indexPath.section][@"assets"] copy];
        [self.navigationController pushViewController:detailsVC animated:YES];
    } else {
        NSLog(@"该相册内没有照片");
    }
}

- (void)leftButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //发送assets数据
         [[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoAssets" object:nil userInfo:@{@"assetsArray":[UserData1 userDataStandard].photoAssets}];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
