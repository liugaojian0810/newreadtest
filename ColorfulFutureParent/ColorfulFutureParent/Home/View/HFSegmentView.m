//
//  HFSegmentView.m
//  ColorfulFuturePrincipal
//
//  Created by 刘高见 on 2020/5/16.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFSegmentView.h"

// 获得RGB颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface HFSegmentView ()
{
    NSArray *tempArray;
}
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation HFSegmentView

+ (HFSegmentView *)SegmentView{
//    static HFSegmentView *CustomTabBar = nil;
//    static dispatch_once_t tabBar;
//    dispatch_once(&tabBar, ^{
//    if (!SegmentView) {
    HFSegmentView *  segmentView =[[self alloc] init];
//    }
//    });
    
    return segmentView;
}

+ (HFSegmentView *)setTabBarPoint:(CGPoint)points height:(CGFloat)height{
    return [[HFSegmentView SegmentView] setTabBarPoint:points height:height];
}

+ (HFSegmentView *)setTabBarPoint:(CGPoint)points{
    return [[HFSegmentView SegmentView] setTabBarPoint:points];
}


- (HFSegmentView *)setTabBarPoint:(CGPoint)point height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    frame.size.height = height;
    self.contentHeight = height;
    self.frame = frame;
    return self;
}

- (HFSegmentView *)setTabBarPoint:(CGPoint)point{
    CGRect frame = self.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    self.frame = frame;
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    self.frame = CGRectMake(0, 0, HFCREEN_WIDTH, 44);
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = HFRGBAColor(235, 241, 245, 1).CGColor;
}

- (void)setData:(NSArray *)titles NormalColor:(UIColor *)normal_color SelectColor:(UIColor *)select_color Font:(UIFont *)font{
    
    tempArray = titles;
    CGFloat _width = HFCREEN_WIDTH / titles.count;
    
    for (int i = 0; i < titles.count; i++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(i * _width, 0, _width, CGRectGetHeight(self.frame)-3);
        [item setTitle:titles[i] forState:UIControlStateNormal];
        [item setTitleColor:normal_color forState:UIControlStateNormal];
        [item setTitleColor:select_color forState:UIControlStateSelected];
        item.titleLabel.font = font;
        item.tag = i + 10;
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        if (i == 0) {
            item.selected = YES;
            self.selectedBtn = item;
            self.lineView = [[UIView alloc]initWithFrame:CGRectMake((_width-15)/2, CGRectGetHeight(self.frame) - 3, 15, 1.5)];
            self.lineView.layer.cornerRadius = 0.75;
            self.lineView.backgroundColor = kColor(244, 92, 42);
            self.lineView.layer.masksToBounds = YES;
            [item.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:17]];
            [self addSubview:self.lineView];
        }
    }
}

- (void)clickItem:(UIButton *)button{
    
    [self setAnimation:button.tag-10];
    
    if (self.indexBlock != nil) {
        self.indexBlock(tempArray[button.tag-10],button.tag-10);
    }
}

/***********************【属性】***********************/

- (void)setLineColor:(UIColor *)lineColor{
    self.lineView.backgroundColor = lineColor;
}

- (void)setLineHeight:(CGFloat)lineHeight{
    CGRect frame = self.lineView.frame;
    frame.size.height = lineHeight;
    frame.origin.y = CGRectGetHeight(self.frame) - lineHeight - 1;
    self.lineView.frame = frame;
}

-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    CGRect frame = self.lineView.frame;
    frame.size.width = lineWidth;
    frame.origin.x = (CGRectGetWidth(self.frame)/2 - lineWidth)/2;
    self.lineView.frame = frame;
}



- (void)setLineCornerRadius:(CGFloat)lineCornerRadius{
    self.lineView.layer.cornerRadius = lineCornerRadius;
}

-(void)setBgColor:(UIColor *)bgColor{
    for (id btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)btn;
            button.backgroundColor = bgColor;
        }
    }
}
/***********************【回调】***********************/

- (void)getViewIndex:(IndexBlock)block{
    self.indexBlock = block;
}

+ (void)setViewIndex:(NSInteger)index{
    [[HFSegmentView SegmentView] setViewIndex:index];
}

- (void)setViewIndex:(NSInteger)index{
    if (index < 0) {
        index = 0;
    }
    
    if (index > tempArray.count - 1) {
        index = tempArray.count - 1;
    }
    
    [self setAnimation:index];
}

/**
 *  设置移动的制定下表对应的文字
 *
 *  @param index 下标
 */
-(void)setTitle:(NSString *)title wiewIndex:(NSInteger)index{
    
    for (UIButton *button in self.subviews) {
        if (button.tag == index + 10) {
            [button setTitle:title forState:UIControlStateNormal];
        }
    }
    
}


/***********************【其他】***********************/

- (void)setAnimation:(NSInteger)index{
    
    UIButton *tempBtn = (UIButton *)[self viewWithTag:index+10];
    self.selectedBtn.selected = NO;
    tempBtn.selected = YES;
    self.selectedBtn = tempBtn;
    CGFloat with = HFCREEN_WIDTH / tempArray.count;
    CGFloat x = index * (HFCREEN_WIDTH / tempArray.count);
    [UIView animateWithDuration:0.3 animations:^{
        if (self.lineWidth) {
            self.lineView.jk_centerX = self.selectedBtn.jk_centerX;
        }else{
            CGRect frame = self.lineView.frame;
            frame.origin.x = x+ (with - 15) / 2;
            self.lineView.frame = frame;
        }
    }];
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = subView;
            if (button.selected == YES) {
                [button.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:17]];
            }else{
                [button.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:14]];
            }
        }
    }
}
- (void)dealloc
{
    
}

@end

