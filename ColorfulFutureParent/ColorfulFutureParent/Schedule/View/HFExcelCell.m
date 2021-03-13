//
//  HFExcelCell.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFExcelCell.h"
#import "HFParentScheduleDetailItem.h"
#import "HFParentScheduleRowTitle.h"
#import "HFPrincipalScheduleIColumnTitle.h"
#import "HFPrincipalScheduleIDetailItem.h"
#import "HFSchedulModel.h"


@interface HFExcelCell ()
<UIScrollViewDelegate>
{
    UILabel *_titleLabel;
    
    BOOL _isAllowedNotification;
    BOOL _showBorder;
    
    CGFloat _lastOffX;
    CGFloat _defalutWidth;
    CGFloat _titleWidth;
    
    NSInteger _mode;
    NSInteger _item;
    NSString *_notif;
    
}
@end

@implementation HFExcelCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    parameter:(NSDictionary *)parameter{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _notif = parameter[@"notification"];
        _defalutWidth = [parameter[@"defalutWidth"] floatValue];
        _mode = [parameter[@"mode"] integerValue];
        _item = [parameter[@"item"] integerValue];
        _isParentSchedule = YES;
        _showBorder = [parameter[@"showBorder"] boolValue];
        [self initUIWidths:parameter[@"itemWidths"] showBorderColor:parameter[@"color"]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:_notif object:nil];
    }
    return self;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    parameter:(NSDictionary *)parameter
                    indexPath:(NSIndexPath *)indexPath
                     schedule:(HFSchedulModel *)schedule{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _notif = parameter[@"notification"];
        _defalutWidth = [parameter[@"defalutWidth"] floatValue];
        _mode = [parameter[@"mode"] integerValue];
        _item = [parameter[@"item"] integerValue];
        _isParentSchedule = YES;
        _showBorder = [parameter[@"showBorder"] boolValue];
        _tempIndexPath = [indexPath copy];
        _section = indexPath.section;
        _row = indexPath.row;
        _schedule = schedule;
        [self initUIWidths:parameter[@"itemWidths"] showBorderColor:parameter[@"color"]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:_notif object:nil];
        
    }
    return self;
}



- (void)initUIWidths:(NSArray *)itemWidths
     showBorderColor:(UIColor *)color{
    
    CGSize size = self.contentView.frame.size;
    if (itemWidths && itemWidths.count > 0) {
        _titleWidth = [itemWidths.firstObject floatValue];
    }else{
        _titleWidth = _defalutWidth;
    }
    if (_mode == 0) {
        if (self.isParentSchedule) {
            HFParentScheduleRowTitle *rowTitle =  [[[NSBundle mainBundle]loadNibNamed:@"HFParentScheduleRowTitle" owner:nil options:nil] lastObject];
//            rowTitle.frame =  CGRectMake(0, 0, _titleWidth, 38);
            rowTitle.frame =  CGRectMake(0, 0, _titleWidth, 47);
            HFSchedulDetailMessage *msg = self.schedule.curriculumType.yAxisList[self.row];
            rowTitle.msg = msg;
            [self.contentView addSubview:rowTitle];
        }else{
            [self.contentView addSubview:self.nameLabel];
            if (_showBorder) {
                self.nameLabel.layer.borderWidth = .5;
                self.nameLabel.layer.borderColor = color.CGColor;
            }
        }
//        self.rightScrollView.frame = CGRectMake(_titleWidth, 0, size.width-_titleWidth, 38);
        self.rightScrollView.frame = CGRectMake(_titleWidth, 0, size.width-_titleWidth, 47);
        [self createLabels:_item widths:itemWidths showBorderColor:color];
    }else if (_mode == 1){
//        self.rightScrollView.frame = CGRectMake(0, 0, size.width, 38);
        self.rightScrollView.frame = CGRectMake(0, 0, size.width, 47);
        [self createLabelsInScrollView:_item widths:itemWidths showBorderColor:color];
    }
    self.rightScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;//自适应宽度|高度

    CGRect rect = self.contentView.frame;
//    rect.size.height = 38;
    rect.size.height = 47;
    self.contentView.frame = rect;
    [self.contentView addSubview:self.rightScrollView];
}
- (void)createLabels:(NSInteger)items
              widths:(NSArray *)itemWidths
     showBorderColor:(UIColor *)color{
    
    CGSize size = self.contentView.frame.size;
    CGFloat totalWidth = 0;
    CGFloat startX = 0;
    
    if (self.isParentSchedule) {
        
        for (int i = 1; i < items; i ++) {
            CGFloat w = 0;
            if (i < itemWidths.count) {
                w = [itemWidths[i] floatValue];
            }else{
                w = _defalutWidth;
            }
            HFParentScheduleDetailItem *item = [[[NSBundle mainBundle]loadNibNamed:@"HFParentScheduleDetailItem" owner:nil options:nil]lastObject];
//            item.frame = CGRectMake(startX, 0, w, 38);
            item.frame = CGRectMake(startX, 0, w, 47);
            startX = startX + w;
            [self.rightScrollView addSubview:item];
            totalWidth += w;
            item.msgTop.hidden = YES;
            item.msgBottom.hidden = YES;
            item.contentView.backgroundColor = [UIColor whiteColor];
            for (NSInteger index = 0; index < self.schedule.curriculumType.dataList.count; index++) {
                HFSchedulDetailMessage *message =  self.schedule.curriculumType.dataList[index];
//                message.yLocation = @"1";
                if ([message.xLocation integerValue] == i && ([message.yLocation integerValue] - 1) == _tempIndexPath.row) {
                    item.msgTop.hidden = NO;
                    item.msgBottom.hidden = NO;
                    item.msgTop.text = message.name;
                    item.contentView.backgroundColor = [UIColor jk_colorWithHexString:message.colorRandom];
//                    item.msgBottom.text = message.introduction;
                }
            }
            [item layoutIfNeeded];
        }
    }else{
        for (int i = 1; i < items; i ++) {
            CGFloat w = 0;
            if (i < itemWidths.count) {
                w = [itemWidths[i] floatValue];
            }else{
                w = _defalutWidth;
            }
            HFPrincipalScheduleIDetailItem *detailItem = [[[NSBundle mainBundle]loadNibNamed:@"HFPrincipalScheduleIDetailItem" owner:nil options:nil]lastObject];
//            detailItem.frame = CGRectMake(startX, 0, w, size.height);
            detailItem.frame = CGRectMake(startX, 0, w, (HFCREEN_HEIGHT - HFTABBAR_H) / 8);

            if (i%2==0) {
                detailItem. bgView.hidden = NO;
            }else{
                detailItem. bgView.hidden = YES;
            }
            startX = startX + w;
            [self.rightScrollView addSubview:detailItem];
            totalWidth += w;
            [detailItem layoutIfNeeded];
        }
        
//        for (int i = 1; i < items; i ++) {
//            CGFloat w = 0;
//            if (i < itemWidths.count) {
//                w = [itemWidths[i] floatValue];
//            }else{
//                w = _defalutWidth;
//            }
//            UILabel *label1 = [UILabel new];
//            label1.frame = CGRectMake(startX, 0, w, size.height);
//            label1.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应宽度|高度
//            startX = startX + w;
//            label1.font = [UIFont systemFontOfSize:13];
//            label1.textAlignment = NSTextAlignmentCenter;
//            label1.textColor = HFCOLOR_WITH_HEX_1(0x474D68);
//            label1.numberOfLines = 0;
//            if (_showBorder) {
//                label1.layer.borderWidth = .5;
//                label1.layer.borderColor = color.CGColor;
//            }
//            [self.rightScrollView addSubview:label1];
//            totalWidth += w;
//        }
    }
//    if (self.isParentSchedule) {
//        self.rightScrollView.contentSize = CGSizeMake(totalWidth + 70, 0);
//    }else{
//        self.rightScrollView.contentSize = CGSizeMake(totalWidth + 80, 0);
//    }
    
    if (self.isParentSchedule) {
        self.rightScrollView.contentSize = CGSizeMake(totalWidth , 0);
    }else{
        self.rightScrollView.contentSize = CGSizeMake(totalWidth , 0);
    }
}
- (void)createLabelsInScrollView:(NSInteger)items
              widths:(NSArray *)itemWidths
     showBorderColor:(UIColor *)color{
    
    CGSize size = self.contentView.frame.size;
    
    CGFloat totalWidth = 0;
    CGFloat startX = 0;
    for (int i = 0; i < items; i ++) {
        CGFloat w = 0;
        if (i < itemWidths.count) {
            w = [itemWidths[i] floatValue];
        }else{
            w = _defalutWidth;
        }
        UILabel *label1 = [UILabel new];
        label1.frame = CGRectMake(startX, 0, w, size.height);
        label1.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应宽度|高度
        startX = startX + w;
        label1.font = [UIFont systemFontOfSize:14];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = HFCOLOR_WITH_HEX_1(0x848B9C);
        if (_showBorder) {
            label1.layer.borderWidth = 1;
            label1.layer.borderColor = color.CGColor;
        }
        [self.rightScrollView addSubview:label1];
        totalWidth += w;
    }
    self.rightScrollView.contentSize = CGSizeMake(totalWidth, 0);
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _titleWidth, self.contentView.frame.size.height)];
        _nameLabel.autoresizingMask =  UIViewAutoresizingFlexibleHeight;//高度
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:11];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textColor = HFCOLOR_WITH_HEX_1(0xA15430);
        _nameLabel.backgroundColor = HFCOLOR_WITH_HEX_1(0xF2F4F8);
    }
    return _nameLabel;
}
- (UIScrollView *)rightScrollView{
    if (!_rightScrollView) {
        _rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _rightScrollView.showsVerticalScrollIndicator = NO;
        _rightScrollView.showsHorizontalScrollIndicator = NO;
        _rightScrollView.delegate = self;
        _rightScrollView.bounces = NO;
    }
    return _rightScrollView;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;//
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isAllowedNotification = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_isAllowedNotification) {//是自身才发通知去tableView以及其他的cell
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:_notif object:self userInfo:@{@"cellOffX":@(scrollView.contentOffset.x)}];
    }
    _isAllowedNotification = NO;
}

-(void)scrollMove:(NSNotification*)notification
{
    NSDictionary *noticeInfo = notification.userInfo;
    NSObject *obj = notification.object;
    float x = [noticeInfo[@"cellOffX"] floatValue];
    if (obj!=self) {
        _isAllowedNotification = YES;
        if (_lastOffX != x) {
            [_rightScrollView setContentOffset:CGPointMake(x, 0) animated:NO];
        }
        _lastOffX = x;
    }else{
        _isAllowedNotification = NO;
    }
    obj = nil;
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_notif object:nil];
}
//多种手势处理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}


@end
