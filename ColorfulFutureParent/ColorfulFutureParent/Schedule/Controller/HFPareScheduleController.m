//
//  HFPareScheduleController.m
//  ColorfulFuturePrincipal
//
//  Created by ADIQueen on 2020/5/19.
//  Copyright © 2020 huifan. All rights reserved.
//  课程表

#import "HFPareScheduleController.h"
#import <YWRouter/YWRouter.h>
#import "HFExcelView.h"
#import "HFScheduleViewModel.h"
#import "HFSchedulModel.h"
#import "ColorfulFutureParent-Swift.h"

@interface HFPareScheduleController ()<HFExcelViewDataSource,HFExcelViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *scheduleBGView;
@property(nonatomic,assign)BOOL isParent;
@property(nonatomic,strong)UIView *topSliderBgView;
@property(nonatomic,strong)UIImageView *topSliderView;
@property (weak, nonatomic) IBOutlet UIImageView *rightSliderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderTopConstrint;
@property (weak, nonatomic) IBOutlet UIView *rightSliderBgView;
@property (nonatomic ,strong)NSMutableArray *list;
@property (nonatomic ,strong)HFScheduleViewModel *myViewModel;
@property (nonatomic ,strong)HFExcelView *exceView;
@property (weak, nonatomic) IBOutlet UIButton *thisWeekBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastWeekBtn;
@property(nonatomic,assign)BOOL firstLoadUI;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@property (weak, nonatomic) IBOutlet UIView *schduleBgView;
@property (weak, nonatomic) IBOutlet UIView *controllerBgView;
@property (weak, nonatomic) IBOutlet UIButton *weekChoiceBtn;
@property (weak, nonatomic) IBOutlet UIView *weekSelectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weekSelectHeight;

@property (assign, nonatomic)NSInteger culSelect;//当前选中的项目
@property (weak, nonatomic) IBOutlet UIImageView *nodataImg;


@end

@implementation HFPareScheduleController

#pragma mark-------- 懒加载

-(UIImageView *)topSliderView{
    if (!_topSliderView) {
        _topSliderView = [[UIImageView alloc]initWithFrame:CGRectMake(59, 0, 65, 5)];
        _topSliderView.backgroundColor = HFCOLOR_WITH_HEX_1(0xFFFFFF);
        _topSliderView.image = [UIImage imageNamed:@"icon-huadong"];
        _topSliderView.backgroundColor = [UIColor whiteColor];
        _topSliderView.contentMode = UIViewContentModeScaleToFill;
        _topSliderView.layer.cornerRadius = 2.5;
        _topSliderView.layer.masksToBounds = YES;
    }
    return _topSliderView;
}

-(UIView *)topSliderBgView{
    if (!_topSliderBgView) {
        _topSliderBgView = [[UIView alloc]init];
        CGRect rect =  self.scheduleBGView.frame;
        _topSliderBgView.frame = CGRectMake(59, 0, rect.size.width - 10 - 59, 5);
        _topSliderBgView.backgroundColor = [UIColor whiteColor];
        _topSliderBgView.layer.cornerRadius = 2.5;
        _topSliderBgView.layer.masksToBounds = YES;
    }
    return _topSliderBgView;
}

#pragma mark--------设置内阴影效果
-(void)setWithInShadowIn:(UIView *)view isBig:(BOOL)big{
    CAShapeLayer* shadowLayer = [CAShapeLayer layer];
    [shadowLayer setFrame:view.bounds];
    // Standard shadow stuff
    [shadowLayer setShadowColor:[[UIColor colorWithWhite:0 alpha:0.2]CGColor]];
    [shadowLayer setShadowOffset:CGSizeMake(0.0f,0.0f)];
    [shadowLayer setShadowOpacity:1.0f];
    // Causes the inner region in this example to NOT be filled.
    [shadowLayer setFillRule:kCAFillRuleEvenOdd];
    // Create the larger rectangle path.
    CGMutablePathRef path = CGPathCreateMutable();
    if (big) {
        CGPathAddRect(path,NULL,CGRectInset(view.bounds, -2.5, -2.5));
    }else{
        CGPathAddRect(path,NULL,CGRectInset(view.bounds, -5, -5));
    }
    // Add the inner path so it's subtracted from the outer path.
    // someInnerPath could be a simple bounds rect, or maybe
    // a rounded one for some extra fanciness.
    CGFloat numF = (big == YES)? 5 : 2.5;
    CGPathRef someInnerPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:numF].CGPath;
    CGPathAddPath(path,NULL, someInnerPath);
    CGPathCloseSubpath(path);
    [shadowLayer setPath:path];
    CGPathRelease(path);
    [[view layer]addSublayer:shadowLayer];
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    [maskLayer setPath:someInnerPath];
    [shadowLayer setMask:maskLayer];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.controllerBgView.layer.contents = (id)[UIImage imageNamed:@"schdule_bg_big"].CGImage;
    UIImage *image = self.weekChoiceBtn.imageView.image;
    
//    [self.weekChoiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width-3, 0, image.size.width)];
//    [self.weekChoiceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.weekChoiceBtn.titleLabel.bounds.size.width+3, 0, -self.weekChoiceBtn.titleLabel.bounds.size.width)];
    
    [self.weekChoiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [self.weekChoiceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.weekChoiceBtn.titleLabel.bounds.size.width, 0, -self.weekChoiceBtn.titleLabel.bounds.size.width)];
    self.weekChoiceBtn.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    self.weekSelectView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    
    _firstLoadUI = YES;
    _culSelect = 0;
    _weekSelectView.hidden = YES;
    _weekChoiceBtn.hidden = NO;

    self.thisWeekBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.lastWeekBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.thisWeekBtn setTitle:@"本周" forState:UIControlStateNormal];
    [self.lastWeekBtn setTitle:@"下一周" forState:UIControlStateNormal];
    [self.thisWeekBtn setTitle:@"本周" forState:UIControlStateSelected];
    [self.lastWeekBtn setTitle:@"下一周" forState:UIControlStateSelected];
    
    self.thisWeekBtn.selected = YES;
    self.lastWeekBtn.selected = NO;

    
    _myViewModel = [[HFScheduleViewModel alloc]init];
    _myViewModel.type = @"3";
    _myViewModel.tab = @"1";
    _isParent = YES;
    
    [self getDates];
}


-(void)getDates{
    [_myViewModel requestScheduleDates];
    WeakSelf
    [[_myViewModel.fetchGetDatesCommand execute:nil] subscribeError:^(NSError *error) {
        [self dateShowsAssignment];
    } completed:^{
        Strong_Self
        [self dateShowsAssignment];
    }];
}
- (IBAction)thisWeek:(UIButton *)sender {
    self.thisWeekBtn.selected = YES;
    self.lastWeekBtn.selected = NO;
    if (_myViewModel.dates.count > 0) {
        _myViewModel.week = [_myViewModel.dateKeys[0] integerValue];
        _myViewModel.date = _myViewModel.dates[0];
        [self getScheduleData];
    }
}

- (IBAction)lastWeek:(UIButton *)sender {
    self.thisWeekBtn.selected = NO;
    self.lastWeekBtn.selected = YES;
    if (_myViewModel.dates.count > 1) {
        _myViewModel.week = [_myViewModel.dateKeys[1] integerValue];
        _myViewModel.date = _myViewModel.dates[1];
        [self getScheduleData];
    }
}

-(void)dateShowsAssignment{
    if (_myViewModel.dates.count > 0) {
        
        for (UIView *subView in self.weekSelectView.subviews) {
            [subView removeFromSuperview];
        }
        for (NSInteger index = 0; index<  _myViewModel.va_lue.count; index++) {
            HFSchduleWeekSelectView *select = [[[NSBundle mainBundle]loadNibNamed:@"HFSchduleWeekSelectView" owner:nil options:nil]lastObject];
            select.tag = index;
            select.frame = CGRectMake(0, 30 * index, 110, 30);
            if (self.culSelect == index) {
                select.enterImg.hidden = NO;
            }else{
                select.enterImg.hidden = YES;
            }
            select.nameLabel.text = _myViewModel.va_lue[index];
            WeakSelf
            select.selectClosure = ^{
                Strong_Self
                self.culSelect = index;
                for (HFSchduleWeekSelectView *sub in self.weekSelectView.subviews) {
                    if (self.culSelect == sub.tag) {
                        sub.enterImg.hidden = NO;
                    }else{
                        sub.enterImg.hidden = YES;
                    }
                }
                self.weekSelectView.hidden = YES;
                self.weekChoiceBtn.hidden = NO;
                [self.weekChoiceBtn setTitle: self.myViewModel.va_lue[index] forState:UIControlStateNormal];
                self.myViewModel.week = [self.myViewModel.dateKeys[index] integerValue];
                self.myViewModel.date = self.myViewModel.dates[index];
                [self getScheduleData];
            };
            [self.weekSelectView addSubview:select];
        }
        self.weekSelectHeight.constant = 30 * _myViewModel.va_lue.count;
        
        _myViewModel.week = [_myViewModel.dateKeys[0] integerValue];
        _myViewModel.date = _myViewModel.dates[0];
        [self.weekChoiceBtn setTitle:self.myViewModel.va_lue[0] forState:UIControlStateNormal];
        [self getScheduleData];
    }
//    WeakSelf
//    _dateSwitchView.selectBlock = ^(NSInteger num) {
//        Strong_Self
//        NSLog(@"您当前选中的是第几个");
//        self.myViewModel.week = [self.myViewModel.dateKeys[num] integerValue];
//        self.myViewModel.date = self.myViewModel.tempTimes[num];
////        self.myViewModel.week = [self.myViewModel.tempTimes[num] integerValue];
////        self.myViewModel.week = self.myViewModel.dateKeys[num];
//        [self requestScheduDatas];
//    };
}



-(void)getScheduleData{
    [_myViewModel requestScheduleMessage];
    WeakSelf
    [[_myViewModel.fetchGetScheduleCommand execute:nil] subscribeError:^(NSError *error) {
        
    } completed:^{
        Strong_Self
        if (self.exceView != nil) {
            [self.exceView removeFromSuperview];
            [self.topSliderBgView removeFromSuperview];
            [self.topSliderView removeFromSuperview];
        }
        [self resultDeal];
    }];
}

-(void)resultDeal{
    NSArray *yAxisList = self.myViewModel.scheModel.curriculumType.yAxisList;
    NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:@"temp", nil];
    _list = @[].mutableCopy;
    for (NSInteger index = 0; index < yAxisList.count; index++) {
        HFSchedulDetailMessage *yList = yAxisList[index];
        @try {
            NSString *startTime = (yList.startDate.length > 10) ? [yList.startDate substringWithRange:NSMakeRange(11, 5)]:yList.startDate;
            NSString *endTime =  (yList.endDate.length > 10) ? [yList.endDate substringWithRange:NSMakeRange(11, 5)]:yList.endDate;
            NSString *string = [NSString stringWithFormat:@"%@\n|\n%@",startTime,endTime];
            [tempArray addObject:string];
            NSMutableArray *muArray = [NSMutableArray array];
            for (NSInteger index = 0; index < self.myViewModel.scheModel.curriculumType.xAxisList.count; index++) {
                [muArray addObject:[NSString stringWithFormat:@"%ld",index+1]];
            }
            [_list addObject:@{@"grade":string,@"score":[muArray copy]}];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    

    HFExcelViewMode *mode = [HFExcelViewMode new];
    mode.style = HFExcelViewStyleDefalut;
    mode.isParentSchedule = YES;
    mode.headTexts = [tempArray copy];
//    mode.defalutHeight = 38;
    mode.defalutHeight = 47;
    
    
    NSString *monthStr;
    @try {
        monthStr = [[self.weekChoiceBtn.currentTitle componentsSeparatedByString:@"第"] firstObject];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    //推荐使用这样初始化
//    CGRect frame = self.schduleBgView.frame;
    CGRect frame;
    if (HFIsiPhoneX) {
        frame = CGRectMake(44, 0, self.schduleBgView.frame.size.width - 88, self.schduleBgView.frame.size.height);
    }else{
        frame = self.schduleBgView.frame;
    }
//    HFExcelView *exceView = [[HFExcelView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) mode:mode];
    HFExcelView *exceView = [[HFExcelView alloc] initWithFrame:frame mode:mode];
    exceView.monthStr = monthStr;
    exceView.scheduleModel = self.myViewModel.scheModel;
    _exceView = exceView;
    exceView.dataSource = self;
    exceView.showBorder = YES;
    exceView.delegate = self;
    NSArray *arr = [self.weekChoiceBtn.currentTitle componentsSeparatedByString:@"第"];
    if (arr.count > 0) {
        exceView.monthStr = arr[0];
    }
    [self.schduleBgView addSubview:exceView];

    if (self.myViewModel.scheModel.curriculumType.dataList.count == 0 || self.myViewModel.scheModel.curriculumType.xAxisList.count == 0 || self.myViewModel.scheModel.curriculumType.yAxisList.count == 0) {
        self.nodataImg.hidden = false;
        [exceView removeFromSuperview];
    }else{
        self.nodataImg.hidden = YES;
        [self.schduleBgView addSubview:exceView];

    }
    
//    [self.scheduleBGView addSubview:self.topSliderBgView];
//
//    if (_firstLoadUI) {
//        [self setWithInShadowIn:_topSliderBgView isBig:NO];
//        [self setWithInShadowIn:_rightSliderBgView isBig:YES];
//        _firstLoadUI = NO;
//    }
//
//    [self.scheduleBGView addSubview:self.topSliderView];
//
//    if (self.myViewModel.scheModel.curriculumType.dataList.count > 0) {
//        self.bgView.hidden = YES;
//        [self.scheduleBGView bringSubviewToFront:self.bgView];
//    }else{
//        self.bgView.hidden = NO;
//        [self.scheduleBGView bringSubviewToFront:self.bgView];
//    }
//
//    __weak typeof(self)weakSelf = self;
//    exceView.h_offset = ^(CGFloat offset, CGFloat contentSize, CGFloat scrollViewWidth) {
//        CGRect rect =  self.topSliderBgView.frame;
//        CGFloat width = (rect.size.width - 65);
//        CGFloat temp = offset*width/(contentSize - scrollViewWidth);
//        weakSelf.topSliderView.frame = CGRectMake(59 + temp, 0, 65, 5);
//    };
//
//    exceView.v_offset = ^(CGFloat offset, CGFloat contentSize, CGFloat scrollViewWidth) {
//        CGFloat height = 102;
//        CGFloat temp = offset*height/(contentSize - scrollViewWidth);
//        self.sliderTopConstrint.constant = temp;
//    };
}

//多少行
- (NSInteger)excelView:(HFExcelView *)excelView numberOfRowsInSection:(NSInteger)section{

    NSArray *yAxisList = self.myViewModel.scheModel.curriculumType.yAxisList;

    return yAxisList.count;
    //    return _list.count;
}

////多少列
- (NSInteger)itemOfRow:(HFExcelView *)excelView{

    NSArray *xAxisList = self.myViewModel.scheModel.curriculumType.xAxisList;

    return [xAxisList count] + 1;

}

-(NSInteger)numberOfSectionsInExcelView:(HFExcelView *)excelView{
    return 1;
}

- (void)excelView:(HFExcelView *)excelView label:(UILabel *)label textAtIndexPath:(HFIndexPath *)indexPath{
    if (indexPath.row < _list.count) {
        NSDictionary *dict = _list[indexPath.row];
        if (indexPath.item == 0) {
            label.text = dict[@"grade"];
        }else{
            NSArray *values = dict[@"score"];
            NSString *str = values[indexPath.item - 1];
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str];
            [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, str.length)];
            label.attributedText = attributedText;
        }
    }
}


- (NSArray *)widthForItemOnExcelView:(HFExcelView *)excelView{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger index = 0 ; index < 8; index++) {
        if (index == 0) {
            [array addObject:@(55)];
        }else{
            if (HFIsiPhoneX) {
                [array addObject:@((HFCREEN_WIDTH - 55 - 88)/7)];
            }else{
                [array addObject:@((HFCREEN_WIDTH - 55)/7)];
            }
        }
    }
    return array;
}


- (IBAction)backClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)chioceClick:(UIButton *)sender {
    _weekSelectView.hidden = NO;
    _weekChoiceBtn.hidden = YES;
    
}
- (IBAction)changePictureClick:(UIButton *)sender {
    HFScheduleController *schdule = [[HFScheduleController alloc]init];
    [self presentViewController:schdule animated:YES completion:nil];
    
}



@end
