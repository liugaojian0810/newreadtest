//
//  HFInteractStatusListViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/10.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractStatusListViewController.h"
#import "HFInteractStatusTableViewCell.h"
#import "HFInteractStatusListHeaderView.h"

@interface HFInteractStatusListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *interactStatusBackView;
@property (weak, nonatomic) IBOutlet UITableView *interactStatusTableView;
@property (nonatomic, strong)HFInteractStatusListHeaderView *interactHeaderView;
@property (nonatomic, assign)NSInteger status;

@end

@implementation HFInteractStatusListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactStatusTableView.delegate = self;
    self.interactStatusTableView.dataSource = self;
    [self.interactStatusTableView registerNib:[UINib nibWithNibName:@"HFInteractStatusTableViewCell" bundle:nil] forCellReuseIdentifier:@"interactStatusCell"];
    self.interactHeaderView = [[NSBundle mainBundle]loadNibNamed:@"HFInteractStatusListHeaderView" owner:nil options:nil].firstObject;
    self.interactHeaderView.frame = CGRectMake(0, 0, 357, 48);
    self.interactStatusTableView.tableHeaderView = self.interactHeaderView;
    __weak HFInteractStatusListViewController *weakself = self;
    self.interactHeaderView.block = ^(NSInteger tag) {
        weakself.status = tag;
        [weakself.interactStatusTableView reloadData];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 39;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HFInteractStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"interactStatusCell" forIndexPath:indexPath];
    return cell;
}
@end
