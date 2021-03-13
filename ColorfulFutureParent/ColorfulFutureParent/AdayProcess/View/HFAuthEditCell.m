//
//  HFAuthEditCell.m
//  ColorfulFuturePrincipal
//
//  Created by liugaojian on 2020/6/26.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFAuthEditCell.h"


#define EDIT_CONTENT @"0123456789Xx\n"


@implementation HFAuthEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldChnage) name:UITextFieldTextDidChangeNotification object:nil];
    self.textField.delegate = self;
    // Initialization code
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.notCanAddChinese == YES) {
        NSCharacterSet *cs;
        if(textField == self.textField)
        {
             //invertedSet 方法是去反字符,把所有的除了数字的字符都找出来
            cs = [[NSCharacterSet characterSetWithCharactersInString:EDIT_CONTENT] invertedSet];
            //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把  NSArray的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [string isEqualToString:filtered];
            if(!basicTest)
            {
                return NO;
            }
        }
    }
        return YES;
}


-(void)setCanEdit:(BOOL)canEdit{
    _canEdit = canEdit;
    if (canEdit) {
        self.textField.enabled = YES;
    }else{
        self.textField.enabled = NO;
    }
}

-(void)textFieldChnage{
    
    if (self.maxWord > 0) {
        if (self.textField.text.length > self.maxWord) {
            self.textField.text = [self.textField.text substringToIndex:self.maxWord];
        }
    }
    if (self.editBlock) {
        self.editBlock(self.textField.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
