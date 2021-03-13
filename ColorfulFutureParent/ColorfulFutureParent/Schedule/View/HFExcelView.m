//
//  HFExcelView.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFExcelView.h"
#import "HFExcelCell.h"
#import "HFTableViewHeadView.h"
#import "HFScheduleItemWithDateTime.h"
#import "HFParentScheduleItemOrigin.h"
#import "HFParentScheduleColumnTitle.h"
#import "HFPrincipalScheduleIColumnTitle.h"
#import "HFSchedulModel.h"

@interface HFExcelView ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_list;
    
}
@property (nonatomic, assign,getter=isSettingFrame) BOOL settingFrame;
@property (nonatomic,assign,readwrite) HFExcelViewStyle style;
@property (nonatomic, assign) CGFloat headHeight;
@property (nonatomic, assign) BOOL isParent;
@property (nonatomic, assign) CGFloat cellLastX;
@property (nonatomic, assign) CGFloat defalutWidth;
@property (nonatomic, strong) HFExcelCell *excelCell;
@property (nonatomic, strong) UITableView *tableView;



//HFExcelViewStyleDefalut
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic,   copy) NSArray *headtexts;

//通知-name
@property (nonatomic, strong, readwrite) NSString *NotificationID;

//优化获取每列的宽度(只获取一遍)
@property (nonatomic,   copy) NSArray *itemWidths;
@property (nonatomic, assign) NSInteger itemCount;


@end

@implementation HFExcelView
//MARK: --- public
- (instancetype)initWithFrame:(CGRect)frame mode:(HFExcelViewMode *)mode{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initSetingInMode:mode];
    }
    return self;
}
- (void)reloadData{
    [_tableView reloadData];
}
//MARK: -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self getSection];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self getRowInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_style == HFExcelViewStyleDefalut) {
        return [self getDefalutCellTableView:tableView cellForRowAtIndexPath:indexPath];
    }else if (_style == HFExcelViewStylePlain){
        return [self getPlainCellTableView:tableView cellForRowAtIndexPath:indexPath];
    }else if (_style == HFExcelViewStyleheadPlain){
        return [self getDefalutCellTableView:tableView cellForRowAtIndexPath:indexPath];
    }else if (_style == HFExcelViewStyleheadScrollView){
        return [self getPlainCellTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_style == HFExcelViewStyleheadPlain) {
        return [self getStyleheadPlainExcelView:tableView viewForHeaderInSection:section];
    }else if (_style == HFExcelViewStyleheadScrollView){
        return [self getStyleheadScrollViewExcelView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 38;
    return 47;
}
//MARK: --- privated
- (void)initSetingInMode:(HFExcelViewMode *)mode{
//    _headHeight = mode.defalutHeight;
//    _headHeight = 58;
    _headHeight = 60;
    _isParent = mode.isParentSchedule;
    _style = mode.style;
    _defalutWidth = 95;
    _list = @[].mutableCopy;
    _itemWidths = @[];
    _headtexts = mode.headTexts;
    //以当前对象的指针地址为通知的名称，这样可以避免同一个界面，有多个HFExcelView的对象时，引起的通知混乱
    _NotificationID = [NSString stringWithFormat:@"%p",self];
    _showBorderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    _showBorderColor = [UIColor whiteColor];
    switch (_style) {
        case HFExcelViewStyleDefalut:
            [self initStyleWithDefalut];
            break;
        case HFExcelViewStylePlain:
            [self initStyleWithDefalut];
            break;
        case HFExcelViewStyleheadPlain:
            [self initStyleWithHeadPlain];
            break;
        case HFExcelViewStyleheadScrollView:
            [self initStyleWithHeadPlain];
            break;
            
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollMove:) name:_NotificationID object:nil];
}

- (HFTableViewHeadView *)getStyleheadPlainExcelView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HFTableViewHeadView *headView = (HFTableViewHeadView *)[tableView dequeueReusableCellWithIdentifier:@"headView"];
    if (!headView) {
        headView = [[HFTableViewHeadView alloc] initWithReuseIdentifier:@"headView" parameter:@{@"item":@([self item]),@"itemWidths":[self itemWidth],@"defalutWidth":@(_defalutWidth),@"notification":_NotificationID,@"showBorder":@(self.isShowBorder),@"color":self.showBorderColor,@"mode":@"0"}];
    }
    HFIndexPath *index = [HFIndexPath indexPathForItem:0 section:section];
    [_dataSource excelView:self headView:headView.nameLabel textAtIndexPath:index];
    index = nil;
    int i = 1;
    for (UILabel *label in headView.rightScrollView.subviews) {
        HFIndexPath *indexPathCell = [HFIndexPath indexPathForItem:i section:section];
//        [_dataSource excelView:self headView:label textAtIndexPath:indexPathCell];
        indexPathCell = nil;
        i++;
    }
    return headView;
}
- (HFTableViewHeadView *)getStyleheadScrollViewExcelView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HFTableViewHeadView *headView = (HFTableViewHeadView *)[tableView dequeueReusableCellWithIdentifier:@"headScrollectionView"];
    if (!headView) {
        headView = [[HFTableViewHeadView alloc] initWithReuseIdentifier:@"headView" parameter:@{@"item":@([self item]),@"itemWidths":[self itemWidth],@"defalutWidth":@(_defalutWidth),@"notification":_NotificationID,@"showBorder":@(self.isShowBorder),@"color":self.showBorderColor,@"mode":@"1"}];
    }
    int i = 0;
    for (UILabel *label in headView.rightScrollView.subviews) {
        HFIndexPath *indexPathCell = [HFIndexPath indexPathForItem:i section:section];
//        [_dataSource excelView:self headView:label textAtIndexPath:indexPathCell];
        indexPathCell = nil;
        i++;
    }
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (_style == HFExcelViewStyleheadPlain) {
        return _headHeight;
    }else if (_style == HFExcelViewStyleheadScrollView) {
        return _headHeight;
    }
    return 0.001;
}

- (HFExcelCell *)getPlainCellTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HFExcelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plainCell"];
    if (!cell) {
        cell = [[HFExcelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"plainCell" parameter:@{@"item":@([self item]),@"itemWidths":[self itemWidth],@"defalutWidth":@(_defalutWidth),@"notification":_NotificationID,@"showBorder":@(self.isShowBorder),@"color":self.showBorderColor,@"mode":@"1"} indexPath:indexPath schedule:self.scheduleModel];
    }
    int i = 0;
    for (UILabel *label in cell.rightScrollView.subviews) {
        HFIndexPath *indexPathCell = [HFIndexPath indexPathForItem:i row:indexPath.row section:0];
//        [_dataSource excelView:self label:label textAtIndexPath:indexPathCell];
        indexPathCell = nil;
        i++;
    }
    _excelCell = cell;
    _excelCell.isParentSchedule = self.isParent;
    return cell;
}

- (HFExcelCell *)getDefalutCellTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HFExcelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HFExcelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"plainCell" parameter:@{@"item":@([self item]),@"itemWidths":[self itemWidth],@"defalutWidth":@(_defalutWidth),@"notification":_NotificationID,@"showBorder":@(self.isShowBorder),@"color":self.showBorderColor,@"mode":@"0"} indexPath:indexPath schedule:self.scheduleModel];
    }
    HFIndexPath *index = [HFIndexPath indexPathForItem:0 row:indexPath.row section:0];
    [_dataSource excelView:self label:cell.nameLabel textAtIndexPath:index];
//    index = nil;
//    int i = 1;
//    for (UILabel *label in cell.rightScrollView.subviews) {
//        HFIndexPath *indexPathCell = [HFIndexPath indexPathForItem:i row:indexPath.row section:0];
//        cell.indexPath = index;
////        [_dataSource excelView:self label:label textAtIndexPath:indexPathCell];
//        indexPathCell = nil;
//        i++;
//    }
    _excelCell = cell;
    _excelCell.isParentSchedule = self.isParent;
    return cell;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!CGRectIsEmpty(self.frame)&& !_settingFrame) {
        switch (_style) {
            case HFExcelViewStyleDefalut:
                [self layoutStyleWithDefalut];
                break;
            case HFExcelViewStylePlain:
                [self layoutStyleWithDefalut];
                break;
            case HFExcelViewStyleheadPlain:
                [self layoutStyleWithHeadPlain];
                break;
            case HFExcelViewStyleheadScrollView:
                [self layoutStyleWithHeadPlain];
                break;
            default:
                break;
        }
    }
    
}
//MARK: --- _delegate

- (NSInteger)getSection{
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfSectionsInExcelView:)]) {
        return [_dataSource numberOfSectionsInExcelView:self];
    }
    return 1;
}
- (NSInteger)getRowInSection:(NSInteger)section{
    if (_dataSource && [_dataSource respondsToSelector:@selector(excelView:numberOfRowsInSection:)]) {
        return [_dataSource excelView:self numberOfRowsInSection:section];
    }
    return 0;
}
- (NSInteger)item{
    
    if (_itemCount != 0) {
        return _itemCount;
    }
    _itemCount = [_dataSource itemOfRow:self];
    
    return _itemCount;
}
- (NSArray *)itemWidth{
    
    if (_itemWidths.count > 0) {
        return _itemWidths;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(widthForItemOnExcelView:)]) {
        _itemWidths = [_delegate widthForItemOnExcelView:self];
    }
    return _itemWidths;
}

- (void)setShowBorder:(BOOL)showBorder{
    _showBorder = showBorder;
    if (showBorder) {
        self.layer.borderWidth = .5;
        self.layer.borderColor = _showBorderColor.CGColor;
    }else{
        self.layer.borderWidth = 0;
    }
}

//MARK: --- UI

- (void)initStyleWithDefalut{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    UIView *headV = [UIView new];
    [self addSubview:headV];
    _headView = headV;
//    _tableView.rowHeight = _headHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
}
- (void)initStyleWithHeadPlain{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.rowHeight = _headHeight;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    [self addSubview:_tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}


- (void)layoutStyleWithDefalut{
    
    CGFloat w = CGRectGetWidth(self.frame);
    _headView.frame = CGRectMake(0, 0, w, _headHeight);
//    _headView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tableView.frame = CGRectMake(0, _headHeight, w, CGRectGetHeight(self.frame) - _headHeight);
//    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if (_style == HFExcelViewStylePlain) {
        [self creatHeadViewPlayin];
    }else{
        [self creatHeadView];
    }
    _settingFrame = YES;
}

- (void)layoutStyleWithHeadPlain{
    CGFloat w = CGRectGetWidth(self.frame);
    _tableView.frame = CGRectMake(0, 0, w, CGRectGetHeight(self.frame) );
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _settingFrame = YES;
}

- (void)creatHeadView{
    
    NSInteger count = [self item];
    NSArray *arr = [self itemWidth];
    CGFloat lblW = arr.count > 0 ? [[arr firstObject] floatValue] : _defalutWidth;
    
    //左上角的坐标原点
    if (self.isParent) {
        HFParentScheduleItemOrigin *view = [[[NSBundle mainBundle]loadNibNamed:@"HFParentScheduleItemOrigin" owner:nil options:nil]lastObject];
        view.frame =  CGRectMake(0, 0, lblW, _headHeight);
        view.monthStr = self.monthStr;
        [_headView addSubview:view];
    }else{
        HFScheduleItemWithDateTime *view = [[[NSBundle mainBundle]loadNibNamed:@"HFScheduleItemWithDateTime" owner:nil options:nil]lastObject];
        view.frame =  CGRectMake(0, 0, lblW, _headHeight);
        [_headView addSubview:view];
        if (self.isShowBorder) {
            view.layer.borderWidth = .5;
            view.layer.borderColor = _showBorderColor.CGColor;
        }
    }
    //顶部滚轴scrollView
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(lblW, 0, self.frame.size.width-lblW, _headHeight)];
//    self.topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    CGFloat totalWidth = 0;
    CGFloat startX = 0;
    
    if (self.isParent) {
        
        for (int  i = 1; i < count; i ++) {
            HFParentScheduleColumnTitle *columnTitle = [[[NSBundle mainBundle]loadNibNamed:@"HFParentScheduleColumnTitle" owner:nil options:nil]lastObject];
            if (i < arr.count ) {
                CGFloat sW = [arr[i] floatValue];
                columnTitle.frame = CGRectMake(startX, 0, sW, _headHeight);
                startX = sW + startX;
                totalWidth += sW;
            }else{
                columnTitle.frame = CGRectMake(startX, 0, _defalutWidth, _headHeight);
                startX = _defalutWidth + startX;
                totalWidth += _defalutWidth;
            }
            HFSchedulDetailMessage *msg = self.scheduleModel.curriculumType.xAxisList[i-1];
            NSString *str = [self getDate];
            if ([str containsString:msg.date]) {
                columnTitle.dateLabel.hidden = YES;
                columnTitle.todayLabel.hidden = NO;
            }else{
                columnTitle.dateLabel.hidden = NO;
                columnTitle.todayLabel.hidden = YES;
            }
            columnTitle.msg = msg;
            [self.topScrollView addSubview:columnTitle];
        }
        
    }else{
        for (int  i = 1; i < count; i ++) {
            HFPrincipalScheduleIColumnTitle *colomn = [[[NSBundle mainBundle]loadNibNamed:@"HFPrincipalScheduleIColumnTitle" owner:nil options:nil]lastObject];
            if (i < arr.count ) {
                CGFloat sW = [arr[i] floatValue];
                colomn.frame = CGRectMake(startX, 0, sW, _headHeight);
                startX = sW + startX;
                totalWidth += sW;
            }else{
                colomn.frame = CGRectMake(startX, 0, _defalutWidth, _headHeight);
                startX = _defalutWidth + startX;
                totalWidth += _defalutWidth;
            }
            [self.topScrollView addSubview:colomn];
        }
        
    }
    self.topScrollView.contentSize = CGSizeMake(totalWidth, 0);
    self.topScrollView.delegate = self;
    self.topScrollView.bounces = NO;
    [_headView addSubview:self.topScrollView];
    [_list addObject:self.topScrollView];
}

-(NSString *)getDate{
    return [NSString stringWithFormat:@"%@",[NSDate date]];
}


- (void)creatHeadViewPlayin{
    NSInteger count = [self item];
    NSArray *arr = [self itemWidth];
    
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _headHeight)];
    self.topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    CGFloat totalWidth = 0;
    CGFloat startX = 0;
    for (int  i = 0; i < count; i ++) {
        UILabel *label = [UILabel new];
        if (i < arr.count ) {
            CGFloat sW = [arr[i] floatValue];
            label.frame = CGRectMake(startX, 0, sW, _headHeight);
            startX = sW + startX;
            totalWidth += sW;
        }else{
            label.frame = CGRectMake(startX, 0, _defalutWidth, _headHeight);
            startX = _defalutWidth + startX;
            totalWidth += _defalutWidth;
        }
        if (i < _headtexts.count) {
            label.text = _headtexts[i];
        }
        if (self.isShowBorder) {
            label.layer.borderWidth = .5;
            label.layer.borderColor = _showBorderColor.CGColor;
        }
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [self.topScrollView addSubview:label];
    }
    self.topScrollView.contentSize = CGSizeMake(totalWidth, 0);
    self.topScrollView.delegate = self;
    self.topScrollView.bounces = NO;
    [_headView addSubview:self.topScrollView];
    [_list addObject:self.topScrollView];
}

- (void)setShowsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator{
    _showsVerticalScrollIndicator = showsVerticalScrollIndicator;
    _tableView.showsVerticalScrollIndicator = self.isShowsVerticalScrollIndicator;
}

#pragma mark-- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([_list containsObject:scrollView]) {
        //判断为headView滚动，改变cell内部的rightScrollView的偏移量
        CGPoint offSet = _excelCell.rightScrollView.contentOffset;
        offSet.x = scrollView.contentOffset.x;
        //_excelCell使用改变量的因为方便，只要一个cell滑动，便触发通知
        _excelCell.rightScrollView.contentOffset = offSet;
        for (UIScrollView *bg in _list) {
            if (![bg isEqual:scrollView]) {
                bg.contentOffset = offSet;
            }
        }
    }
    if (self.scheduleModel.curriculumType.yAxisList.count == 0) {
        if ([scrollView isEqual:self.topScrollView]) {
            if (self.h_offset) {
                self.h_offset(self.topScrollView.contentOffset.x,self.topScrollView.contentSize.width,self.topScrollView.frame.size.width);
            }
        }
    }else{
        if ([scrollView isEqual:self.tableView]) {
            if (self.v_offset) {
                self.v_offset(self.tableView.contentOffset.y,self.tableView.contentSize.height,self.tableView.frame.size.height);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:_NotificationID object:self userInfo:@{@"cellOffX":@(self.cellLastX)}];
        }
    }

}
-(void)scrollMove:(NSNotification*)notification{
    
    NSDictionary *noticeInfo = notification.userInfo;
    float x = [noticeInfo[@"cellOffX"] floatValue];
    //    NSLog(@"view收到===%f",x);
    if (self.cellLastX != x) {//避免重复设置偏移量
        self.cellLastX = x;
        if (self.topScrollView) {
            CGPoint offSet = self.topScrollView.contentOffset;
            offSet.x = x;
            self.topScrollView.contentOffset = offSet;
            if (self.h_offset) {
                self.h_offset(x,self.topScrollView.contentSize.width,self.topScrollView.frame.size.width);
            }
        }
        
    }
    noticeInfo = nil;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_NotificationID object:nil];
}

@end

