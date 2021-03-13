//
//  HFPageControl.m
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/11.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFPageControl.h"
#import "UIColor+HF.h"
#import "UIImage+HGJ.h"

#define itemsCount self.numberOfPages

#define itemWidth self.itemWidth
#define itemHeight self.itemHeight
#define itemSpacing self.itemSpacing

#define selectedImage ((self.selectedImage) ? self.selectedImage : [UIImage getImageWithColor:self.selectedColor])
#define unselectedImage ((self.unselectedImage) ? self.unselectedImage : [UIImage getImageWithColor:self.unselectedColor])

@implementation HFPageControl

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    
    if (self.subviews.count) {
        for (int i = 0; i < self.subviews.count; i++) {
            UIButton *btn = self.subviews[i];
            btn.selected = (currentPage == i) ? YES : NO;
        }
    }
}

- (void)setupPageControl {
    for (int i = 0; i < itemsCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(itemWidth+itemSpacing), 0, itemWidth, itemHeight);
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 1;
        btn.layer.masksToBounds = YES;
        [btn setBackgroundImage:unselectedImage forState:UIControlStateNormal];
        [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
        btn.selected = (i == self.currentPage) ? YES : NO;
        [self addSubview:btn];
    }
}

@end
