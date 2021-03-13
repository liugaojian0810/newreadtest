//
//  HFChangeInfoView.h
//  ColorfulFuturePrincipal
//
//  Created by 李春展 on 2020/5/17.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFChangeInfoView : UIView

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verfiCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBut;
@property (weak, nonatomic) IBOutlet UIView *getCodeView;
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UILabel *passRuleLab;
@property (weak, nonatomic) IBOutlet UIButton *completeBut;

@end

NS_ASSUME_NONNULL_END
