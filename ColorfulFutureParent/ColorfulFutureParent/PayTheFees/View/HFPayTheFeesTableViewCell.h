//
//  HFPayTheFeesTableViewCell.h
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/22.
//  Copyright © 2020 huifan. All rights reserved.
//


#import "HFPayTheFeesListModel.h"
#import <UIKit/UIKit.h>

typedef void(^payTheFeesSelectBlock)(NSInteger row);
typedef void(^payTheFeesisMonthBlock)(NSString * _Nonnull tagAndRow);

NS_ASSUME_NONNULL_BEGIN

@interface HFPayTheFeesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWidthNum;
@property (weak, nonatomic) IBOutlet UILabel *leftPrice;
@property (weak, nonatomic) IBOutlet UILabel *leftTime;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UILabel *middlePrice;
@property (weak, nonatomic) IBOutlet UILabel *middleTime;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBtnWidth;
@property (nonatomic, strong) ProjectsListModel *dataModel;
@property (nonatomic, copy) payTheFeesSelectBlock selectBlock;
@property (nonatomic, copy) payTheFeesisMonthBlock isMonthBlock;
- (void)updataColorView:(BOOL)isLeftView;
@end

NS_ASSUME_NONNULL_END
