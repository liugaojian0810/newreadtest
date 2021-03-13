//
//  HFExcelCell.h
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/20.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFIndexPath.h"
@class HFSchedulModel;

NS_ASSUME_NONNULL_BEGIN

@interface HFExcelCell : UITableViewCell

@property (nonatomic, strong) UIScrollView *rightScrollView;

@property (nonatomic, strong) HFIndexPath *indexPath;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, assign)BOOL isParentSchedule;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    parameter:(NSDictionary *)parameter;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    parameter:(NSDictionary *)parameter
                    indexPath:(NSIndexPath *)indexPath
                     schedule:(HFSchedulModel *)schedule;

@property (nonatomic, strong) NSIndexPath *tempIndexPath;

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) HFSchedulModel *schedule;

@end

NS_ASSUME_NONNULL_END
