//
//  HFTableViewCell.m
//  ColorfulFutureTeacher_iOS
//
//  Created by Mac on 2020/5/21.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFTableViewCell.h"

@implementation HFTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addMySubViews];
        [self addMasonry];
    }
    return self;
}

- (void)addMySubViews {
    
}

- (void)addMasonry {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
