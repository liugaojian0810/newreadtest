//
//  HFFeedbackCollectionViewCell.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFFeedbackCollectionViewCell.h"

@implementation HFFeedbackCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)closeAction:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

@end
