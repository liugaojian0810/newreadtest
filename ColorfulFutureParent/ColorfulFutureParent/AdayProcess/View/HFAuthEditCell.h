//
//  HFAuthEditCell.h
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/6/26.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^HFAuthEditBlock)(NSString *editStr);

@interface HFAuthEditCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *arrIntoImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textRightConstrint;

@property (assign, nonatomic) BOOL canEdit;
@property(nonatomic, copy)HFAuthEditBlock editBlock;

@property (assign, nonatomic) BOOL notCanAddChinese;
@property (assign, nonatomic) NSInteger maxWord;

@end

NS_ASSUME_NONNULL_END
