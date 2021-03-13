//
//  UITableView+LGJExtension.m
//  WeiGe
//
//  Created by ADIQueen on 2018/8/16.
//  Copyright © 2018年 teacher of china. All rights reserved.
//

#import "UITableView+LGJExtension.h"
#import <JKCategories/JKCategories.h>
@implementation UITableView (LGJExtension)

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark------设置默认的无内容时候的背景

void swizzMethod(SEL oriSel, SEL newSel) {
    
    Class class = [UITableView class];
    Method oriMethod = class_getInstanceMethod(class, oriSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    BOOL success = class_addMethod(class, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (success) {
        class_replaceMethod(class, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"tt_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        swizzMethod(originalSelector, swizzledSelector);
    }
}

- (void)tt_reloadData {
    [self tt_reloadData];
    [self showPlaceholderNotice];
}

- (void)tt_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self tt_insertSections:sections withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)tt_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self tt_deleteSections:sections withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)tt_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self tt_reloadSections:sections withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)tt_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self tt_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)tt_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self tt_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)tt_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self tt_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self showPlaceholderNotice];
}

- (void)showPlaceholderNotice {
    if (self.showNoDataNotice) {
        NSInteger sectionCount = self.numberOfSections;
        NSInteger rowCount = 0;
        for (int i = 0; i < sectionCount; i++) {
            rowCount += [self.dataSource tableView:self numberOfRowsInSection:i];
        }
        if (rowCount == 0) {
            if (self.customNoDataView) {
                self.backgroundView = [self customNoDataView];
            } else
                self.backgroundView = [self tt_defaultNoDataView];
        } else {
            self.backgroundView = [[UIView alloc] init];
        }
    }
}

- (UIView *)tt_defaultNoDataView {
    
    if (self.defaultNoDataView) {
        return self.defaultNoDataView;
    }
    self.defaultNoDataView = ({
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tt_tapDefalutNoDataView:)];
        [view addGestureRecognizer:tap];
        
        [view addSubview:self.defaultNoDataNoticeImageView];
        [view addSubview:self.defaultNoDataNoticeLabel];
        [view addSubview:self.defaultOperationBtn];
        
        [self.defaultOperationBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self layoutDefaultView:view];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        view;
    });
    
    return self.defaultNoDataView;
}

- (void)layoutDefaultView:(UIView *)defaultView {
    
    UIImageView *imageView = self.defaultNoDataNoticeImageView;
    UIImage *image = self.defaultNoDataImage ? : [UIImage imageNamed:@"qs-zanwudingdan"];
    if (self.noContentType == HFNoContentTypeNoContent) {
        image =  [[UIImage imageNamed:@"empty_img_shuju"] copy];
    }else if (self.noContentType == HFNoContentTypeNoNetwork){
        image = [[UIImage imageNamed:@"qs-zanwuwangl"] copy];
    }else if (self.noContentType == HFNoContentTypeNoOrder){
        image = [[UIImage imageNamed:@"qs-zanwudingdan"] copy];
    }else if (self.noContentType == HFNoContentTypeNone){
        image = [[UIImage imageNamed:@""] copy];
    }else if (self.noContentType == HFNoContentTypeShoppingCart){
        image = [[UIImage imageNamed:@"empty_img_gouwu"] copy];
    }else if (self.noContentType == HFNoContentTypeNotInteractive){
        image = [[UIImage imageNamed:@"empty_img_not_interactive"] copy];
    }else{
        image =  [[UIImage imageNamed:@"empty_img_shuju"] copy];
    }
    imageView.image = image;
    CGFloat XX = (self.bounds.size.width - image.size.width - self.contentInset.left - self.contentInset.right) / 2;
    CGFloat YY = (self.bounds.size.height - image.size.height - self.contentInset.top - self.contentInset.bottom) / 2 - 50;
    imageView.frame = CGRectMake(XX, YY, image.size.width, image.size.height);
    
    // 提示语不用太长，不考虑换行的情况，也不计算文字的宽高了
    UILabel *label = self.defaultNoDataNoticeLabel;
    label.text = self.defaultNoDataText ? : label.text;
    label.frame = CGRectMake(0, imageView.frame.origin.y + imageView.bounds.size.height + 20, self.bounds.size.width, 15);
    
    //缺省页面的操作按钮
    UIButton *btn = self.defaultOperationBtn;
    btn.frame = CGRectMake((HFCREEN_WIDTH-100)/2, label.frame.origin.y + label.bounds.size.height + 10, 100, 32);
    // gradient
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = btn.frame;
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:231/255.0 green:190/255.0 blue:115/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:235/255.0 green:147/255.0 blue:72/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    btn.layer.cornerRadius = 16;
    [btn.layer addSublayer:gl];
    
}

- (void)tt_tapDefalutNoDataView:(UITapGestureRecognizer *)tap {
    
    self.noDataViewDidClickBlock ? self.noDataViewDidClickBlock(self.defaultNoDataView) : nil;
}

-(void)btnClick:(UIButton *)sender{
//    UIViewController *vc = [self viewController];
    if ([sender.currentTitle isEqualToString:@"去设置"]) {
        NSURL *url= [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{}completionHandler:^(BOOL        success) {
                }];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication]openURL:url];
            }
        }
    }else{
        
    }
    self.noDataBtnDidClickBlock ? self.noDataBtnDidClickBlock(self.defaultOperationBtn) : nil;
}

- (UIViewController*)viewController {
    UIResponder *nextResponder =  self;
    do {
        nextResponder = [nextResponder nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
    } while (nextResponder != nil);
    
    return nil;
}

#pragma mark - notifications
- (void)onDeviceOrientationChange:(NSNotification *)noti {
    if (self.customNoDataView || !self.showNoDataNotice) {
        return;
    }
    [self layoutDefaultView:self.defaultNoDataView];
}


#pragma mark - setter && getter
- (void)setShowNoDataNotice:(BOOL)showNoDataNotice {
    objc_setAssociatedObject(self, @selector(showNoDataNotice), @(showNoDataNotice), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showNoDataNotice {
    return objc_getAssociatedObject(self, _cmd) == nil ? YES : [objc_getAssociatedObject(self, _cmd) boolValue];
}



- (void)setNoDataViewDidClickBlock:(void (^)(UIView *))noDataViewDidClickBlock {
    self.showNoDataNotice = YES;
    objc_setAssociatedObject(self, @selector(noDataViewDidClickBlock), noDataViewDidClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIView *))noDataViewDidClickBlock {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setNoDataBtnDidClickBlock:(void (^)(UIButton *))noDataBtnDidClickBlock{
    objc_setAssociatedObject(self, @selector(noDataBtnDidClickBlock), noDataBtnDidClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(UIButton *))noDataBtnDidClickBlock{
    return objc_getAssociatedObject(self, _cmd);
}



- (void)setCustomNoDataView:(UIView *)customNoDataView {
    self.showNoDataNotice = YES;
    objc_setAssociatedObject(self, @selector(customNoDataView), customNoDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)customNoDataView {
    return objc_getAssociatedObject(self, _cmd);
}





- (UIView *)defaultNoDataView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDefaultNoDataView:(UIView *)defaultNoDataView {
    objc_setAssociatedObject(self, @selector(defaultNoDataView), defaultNoDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 默认的label
- (UILabel *)defaultNoDataNoticeLabel {
    UILabel *label = objc_getAssociatedObject(self, _cmd);
    if (!label) {
        label = [[UILabel alloc] init];
        label.text = self.defaultNoDataText ? : @"当前页面暂无数据哦～";
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor jk_colorWithHexString:@"#CECECE"];
        if (self.noContentType == HFNoContentTypeNoContent) {
            label.text =  @"当前页面暂无数据哦～";
        }else if (self.noContentType == HFNoContentTypeNoNetwork){
            label.text =  @"当前网络不可用，请检查网络配置～";
        }else if (self.noContentType == HFNoContentTypeNoOrder){
            label.text =  @"您还没有订单哦，快去购课吧";
        }else if (self.noContentType == HFNoContentTypeShoppingCart){
            label.text =  @"购物车空空如也～";
        }else if (self.noContentType == HFNoContentTypeNotInteractive){
            label.text = @"暂无互动活动~";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor jk_colorWithHexString:@"#999999"];
        }else if (self.noContentType == HFNoContentTypeNone){
            label.text =  @"";
        }else{
            label.text =  @"当前页面暂无数据哦～";
        }
        label.textAlignment = NSTextAlignmentCenter;
        objc_setAssociatedObject(self, _cmd, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

// 默认的imageView
- (UIImageView *)defaultNoDataNoticeImageView {
    UIImageView *imageView = objc_getAssociatedObject(self, _cmd);
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
//        imageView.image = self.defaultNoDataImage ? : [UIImage imageNamed:@"qs-zanwushuju"];
        imageView.image = self.defaultNoDataImage? self.defaultNoDataImage:[UIImage imageNamed:@"empty_img_shuju"];
        imageView.contentMode = UIViewContentModeCenter;
        objc_setAssociatedObject(self, _cmd, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imageView;
}


-(UIButton *)defaultOperationBtn{
    UIButton *fefaultBtn = objc_getAssociatedObject(self, _cmd);
    if (!fefaultBtn) {
        fefaultBtn = [[UIButton alloc] init];
        
        fefaultBtn.backgroundColor = HFCOLOR_WITH_HEX_1(0xEB9348);
        NSString *btnTitle = self.defaultOperationBtnText ? : @"返回上一页";
        if (self.noContentType == HFNoContentTypeNoContent) {
            btnTitle =  @"返回上一页";
        }else if (self.noContentType == HFNoContentTypeNoNetwork){
            btnTitle =  @"去设置";
        }else if (self.noContentType == HFNoContentTypeNoOrder){
            btnTitle =  @"去购买";
        }else if (self.noContentType == HFNoContentTypeNone){
            btnTitle =  @"";
        }else{
            btnTitle =  @"返回上一页";
        }
        [fefaultBtn setTitle:btnTitle forState:UIControlStateNormal];
        fefaultBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [fefaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        fefaultBtn.contentMode = UIViewContentModeCenter;
        fefaultBtn.hidden = YES;//默认这个按钮先隐藏掉
        objc_setAssociatedObject(self, _cmd, fefaultBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return fefaultBtn;
}



- (NSString *)defaultNoDataText {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDefaultNoDataText:(NSString *)defaultNoticeText {
    self.defaultNoDataNoticeLabel.text = defaultNoticeText;
    objc_setAssociatedObject(self, @selector(defaultNoDataText), defaultNoticeText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)defaultOperationBtnText {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDefaultOperationBtnText:(NSString *)defaultOperationBtnText {
    [self.defaultOperationBtn setTitle:defaultOperationBtnText forState:UIControlStateNormal];
    objc_setAssociatedObject(self, @selector(defaultOperationBtnText), defaultOperationBtnText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


-(HFNoContentType)noContentType{
    return objc_getAssociatedObject(self, _cmd) == nil ? YES : [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setNoContentType:(HFNoContentType)noContentType{
    objc_setAssociatedObject(self, @selector(noContentType), @(noContentType), OBJC_ASSOCIATION_ASSIGN);
}

- (UIImage *)defaultNoDataImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDefaultNoDataImage:(UIImage *)defaultNoticeImage {
    objc_setAssociatedObject(self, @selector(defaultNoDataImage), defaultNoticeImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)hiddenNoContentView{
    
}
@end
