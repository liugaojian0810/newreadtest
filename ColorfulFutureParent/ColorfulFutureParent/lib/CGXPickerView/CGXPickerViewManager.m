//
//  CGXPickerViewManager.m
//  CGXPickerView
//
//  Created by 曹贵鑫 on 2018/1/8.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import "CGXPickerViewManager.h"

@interface CGXPickerViewManager ()

@end
@implementation CGXPickerViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _kPickerViewH = 200;
//        _kTopViewH = 55;
        _kTopViewH = 50;
        _pickerTitleSize = 15;
        _pickerTitleColor = [UIColor blackColor];
        _lineViewColor =CGXPickerRGBColor(225, 225, 225, 1);
        
//        _titleLabelColor = CGXPickerRGBColor(252, 96, 134, 1);
        _titleLabelColor = HFCOLOR_WITH_HEX_1(0x4B4B4B);
        _titleSize = 16;
        _titleLabelBGColor = [UIColor whiteColor];
        
        _rightBtnTitle = @"确认";
        _rightBtnBGColor = HFCOLOR_WITH_HEX_1(0xFA9030);
        _rightBtnTitleSize = 14;
        _rightBtnTitleColor = HFCOLOR_WITH_HEX_1(0xFFFFFF);
        _rightBtnborderColor = HFCOLOR_WITH_HEX_1(0xFA9030);
        _rightBtnCornerRadius = 15;
        _rightBtnBorderWidth = 1;
        
        _leftBtnTitle = @"取消";
        _leftBtnBGColor =  [UIColor whiteColor];
        _leftBtnTitleSize = 14;
        _leftBtnTitleColor = HFCOLOR_WITH_HEX_1(0xFA9030);
        _leftBtnborderColor =  HFCOLOR_WITH_HEX_1(0xFA9030);
        _leftBtnCornerRadius = 15;
        _leftBtnBorderWidth = 1;
    }
    return self;
}
@end
