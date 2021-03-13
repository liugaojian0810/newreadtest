//
//  HFOrderDetialViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/6/5.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFOrderDetialViewController.h"
#import "HFOrderDetailModel.h"
#import "UIView+HFDottedLine.h"
#import <JKCategories/JKCategories.h>
@interface HFOrderDetialViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderCode;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *payType;
@property (weak, nonatomic) IBOutlet UILabel *payTime;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *lessonLab;
@property (weak, nonatomic) IBOutlet UIView *orderBackView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation HFOrderDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"订单详情";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.identifier forKey:@"id"];
    [Service postWithUrl:OrderDetailAPI params:params success:^(id responseObject) {
        [self setDataWithSource:[HFOrderDetailModel mj_objectWithKeyValues:[responseObject valueForKey:@"model"]]];
    } failure:^(HFError *error) {
        [MBProgressHUD showMessage:error.errorMessage];
    }];
    self.orderBackView.layer.cornerRadius = 10;
    self.orderBackView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.orderBackView.layer.shadowOffset = CGSizeMake(0, 1);
    self.orderBackView.layer.shadowOpacity = 0.2;
    self.imageBackView.layer.cornerRadius = 10;
    self.imageBackView.layer.masksToBounds = YES;
    [UIView drawLineOfDashByCAShapeLayer:self.lineView lineLength:1 lineSpacing:3 lineColor:[UIColor jk_colorWithHexString:@"#9F7350"]];
}

- (void)setDataWithSource:(HFOrderDetailModel *)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goodsMainPhotoUrl] placeholderImage:[UIImage imageNamed:@"cloud_place"]];
    self.name.text = model.goodsName;
    NSString *orderCode = [NSString stringWithFormat:@"订单编号:%@",model.orderNo];
    self.orderCode.attributedText = [orderCode stringwith:[UIColor jk_colorWithHexString:@"#78441B"] whith:ARYuanbold(11) with:NSMakeRange(0, 5)];
    self.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",model.gmtCreate];
    NSString *price = [NSString stringWithFormat:@"¥%.2f",[model.showPrice floatValue] * 0.01];
    self.price.attributedText = [price stringwith:[UIColor jk_colorWithHexString:@"#FF691C"] whith:ARYuanbold(12) with:NSMakeRange(0, 1)];
    NSString *payType = [model.payWay isEqualToString:@"umpay"] ? @"支付方式：快捷支付":@"支付方式：分期支付";
    self.payType.attributedText = [payType stringwith:[UIColor jk_colorWithHexString:@"#90501D"] whith:ARYuanbold(11) with:NSMakeRange(payType.length - 5, 5)];
    NSString *payTime = [NSString stringWithFormat:@"付款时间：%@",model.gmtPay];
    self.payTime.attributedText = [payTime stringwith:[UIColor jk_colorWithHexString:@"#90501D"] whith:ARYuanbold(11) with:NSMakeRange(payTime.length - 5, 5)];
    self.lessonLab.text = model.goodsDetails;
    //图片布局
    NSArray *imageNames = [model.goodsDetailsH5 componentsSeparatedByString:@","];
    UIImageView *tempView = nil;
    for (NSString *imageName in imageNames) {
        UIImageView *goladView = [[UIImageView alloc] init];
        [self.imageBackView addSubview:goladView];
        [goladView sd_setImageWithURL:[NSURL URLWithString:imageName] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (nil == tempView) {
                [goladView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(5);
                    make.right.mas_equalTo(-5);
                    make.top.mas_equalTo(self.lessonLab.mas_bottom).offset(10);
                    make.height.mas_equalTo(385).multipliedBy(image.size.width/image.size.height);
                }];
            }else{
                [goladView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(5);
                    make.right.mas_equalTo(-5);
                    make.top.mas_equalTo(tempView.mas_bottom);
                    make.height.mas_equalTo(385).multipliedBy(image.size.width/image.size.height);
                }];
            }
        }];
        
        tempView = goladView;
    }
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tempView.mas_bottom).offset(5);
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
