//
//  THWave.m
//  wave
//
//  Created by thor on 16/9/7.
//  Copyright © 2016年 thor. All rights reserved.
//

#import "THWave.h"

@interface THWave()

// 刷屏器
@property (nonatomic, strong) CADisplayLink *timer;

// 波
@property (nonatomic, strong) CAShapeLayer *waveLayer;

// 偏移量
@property (nonatomic, assign) CGFloat offset;

@end



@implementation THWave

#pragma mark - 初始化方法
- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return  self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return  self;
}

#pragma mark - initUI
- (void)initUI{
    // 设置底色
    self.backgroundColor = [UIColor whiteColor];
    
    // 创建layer
    _waveLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_waveLayer];
}

#pragma mark - 设置浪高
- (void)setWaveHeight:(CGFloat)waveHeight{
    _waveHeight = waveHeight;
    
    CGRect frame = self.bounds;
    frame.origin.y = frame.size.height - self.waveHeight;
    frame.size.height = self.waveHeight;
    _waveLayer.frame = frame;
    
}
#pragma mark - 设置浪色
- (void)setWaveColor:(UIColor *)waveColor{
    _waveColor = waveColor;
    _waveLayer.fillColor = waveColor.CGColor;
}

#pragma mark - 开始和结束动画
- (void)startWaveAnimation{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)endWaveAnimation{
    [self.timer invalidate];
    self.timer = nil;
}
// 动画实现
- (void)wave{
    
    // 1. 随机
    int speed = [@(self.waveSpeed) intValue];
    int num = arc4random() % speed;
    self.offset += num;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.waveHeight;
    CGFloat y = 0.f;
    // 2. 绘线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, height)];
    for (CGFloat x = 0.f; x <= width; x++) {
        y = height * sinf(2*M_PI/self.waveWidth *x - self.offset * 0.0045);
        [path addLineToPoint:CGPointMake(x, y)];
    }
    
    // 3. 返回x等于中心点时的Y值
    CGFloat centerX = self.bounds.size.width / 2.0;
    CGFloat centerY = height * sinf(2*M_PI/self.waveWidth * centerX - self.offset * 0.0045);
    if (self.waveY) {
        self.waveY(centerY);
    }
    
    // 4. 闭合曲线
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path closePath];
    self.waveLayer.path = path.CGPath;
}

#pragma mark - dealloc
- (void)dealloc{
    [self endWaveAnimation];
    
    if (_waveLayer) {
        [_waveLayer removeFromSuperlayer];
        _waveLayer = nil;
    }
}



















@end





































