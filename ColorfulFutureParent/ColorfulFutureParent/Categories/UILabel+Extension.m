//
//  UILabel+Extension.m
//  HuangtaijiDingcan
//
//  Created by WangJian on 15/7/6.
//  Copyright (c) 2015年 Microfastup Corps. All rights reserved.
//

#import "UILabel+Extension.h"
#import <CoreText/CoreText.h>
@implementation UILabel (Extension)
- (void)adjust
{
    CGSize stringSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, stringSize.width, stringSize.height);
}

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

- (void)setColumnSpace:(CGFloat)columnSpace { NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText]; //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
    
}
- (void)setRowSpace:(CGFloat)rowSpace { self.numberOfLines = 0; NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText]; //调整行距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init]; paragraphStyle.lineSpacing = rowSpace; paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight; [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
           self.attributedText = attributedString;
        
    }


@end
