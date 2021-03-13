//
//  HFRuleViewController.m
//  ColorfulFutureParent
//
//  Created by wzz on 2020/7/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFRuleViewController.h"
#import "UILabel+Extension.h"
#import "HFAttributeTapLabel.h"
#import "HFWebManager.h"


@interface HFRuleViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet HFAttributeTapLabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation HFRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"用户登录协议及隐私政策";
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 8;
    [self serviceAgreement];

    [self.topLabel setRowSpace:5];//行高
    [self.bottomLabel setRowSpace:5];
}

-(void)serviceAgreement{
    NSString *str = @"您可以通过了解《家长用户使用协议》及《家长用户隐私政策》及《平台交易支付服务协议》详细信息，如您同意，请点击“同意并使用”开始我们的服务";
    //文本点击回调
    __weak __typeof(&*self)weakSelf = self;
    self.bottomLabel.tapBlock = ^(NSString *string) {
        if ([string isEqualToString:@"《家长用户使用协议》"]) {
            [[HFWebManager sharedHFWebManager]presentWebWithId:@"101" fromVc:weakSelf bottomBlock:^{
            }];
        }else if ([string isEqualToString:@"《家长用户隐私政策》"]) {
            [[HFWebManager sharedHFWebManager]presentWebWithId:@"102" fromVc:weakSelf bottomBlock:^{
            }];
        }else{
            [[HFWebManager sharedHFWebManager]presentWebWithId:@"118" fromVc:weakSelf bottomBlock:^{
            }];
        }
    };
    
    //设置需要点击的字符串，并配置此字符串的样式及位置
    HFAttributeModel *model = [HFAttributeModel new];
    model.range = [str rangeOfString:@"《家长用户使用协议》"];
    model.string = @"《家长用户使用协议》";
    model.alertImg = [UIImage imageNamed:@""];
    model.attributeDic = @{NSForegroundColorAttributeName :[UIColor jk_colorWithHexString:@"#3CA5FC"]};
    
    HFAttributeModel *model1 = [HFAttributeModel new];
    model1.range = [str rangeOfString:@"《家长用户隐私政策》"];
    model1.string = @"《家长用户隐私政策》";
    model1.attributeDic = @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#3CA5FC"]};
    
    HFAttributeModel *model2 = [HFAttributeModel new];
    model2.range = [str rangeOfString:@"《平台交易支付服务协议》"];
    model2.string = @"《平台交易支付服务协议》";
    model2.attributeDic = @{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#3CA5FC"]};
    //label内容赋值
    [self.bottomLabel setText:str attributes:@{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#666666"],NSFontAttributeName:[UIFont systemFontOfSize:13],NSKernAttributeName:@(-1)}
                 tapStringArray:@[model,model1, model2]];
}

- (IBAction)btnAction:(UIButton *)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:@"aaa" forKey:@"isRule"];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)back {
    exit(0);
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
