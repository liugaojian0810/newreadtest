//
//  HFFiveColorsGemstoneProtocolViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/4.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFFiveColorsGemstoneProtocolViewController.h"
#import <JKCategories/JKCategories.h>
@interface HFFiveColorsGemstoneProtocolViewController ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *gemsLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *listViewArr;

@end

@implementation HFFiveColorsGemstoneProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"五彩宝石使用规则";
    for (UIView *view in self.listViewArr) {
         view.layer.borderColor = [UIColor jk_colorWithHexString:@"#FFE2B2"].CGColor;
         view.layer.masksToBounds = YES;
         view.layer.borderWidth = 1;
         view.layer.cornerRadius = 5;
     }
     
     for (UILabel *label in self.gemsLabel) {
         // gradient
         CAGradientLayer *gl = [CAGradientLayer layer];
         gl.frame = label.bounds;
         gl.startPoint = CGPointMake(0.5, 0);
         gl.endPoint = CGPointMake(0.5, 1);
         gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:206/255.0 blue:101/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:255/255.0 green:130/255.0 blue:53/255.0 alpha:1.0].CGColor];
         gl.locations = @[@(0), @(1.0f)];
         [label.layer insertSublayer:gl atIndex:2];

     }
}

@end
