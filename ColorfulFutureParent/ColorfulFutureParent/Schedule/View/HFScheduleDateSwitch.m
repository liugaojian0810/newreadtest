//
//  HFScheduleDateSwitch.m
//  ColorfulFutureTeacher_iOS
//
//  Created by 刘高见 on 2020/5/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFScheduleDateSwitch.h"

@interface HFScheduleDateSwitch ()

@property (nonatomic, assign)NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation HFScheduleDateSwitch

- (void)awakeFromNib {
    [super awakeFromNib];
    _currentIndex = 0;
    self.bgView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.bgView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,-2);
    self.bgView.layer.shadowOpacity = 1;
    self.contentView.layer.shadowRadius = 5;
}

-(void)setNames:(NSArray *)names{
    _names = names;
    if (names.count == 0 ) {
        _leftButton.alpha =.5;
        _rightButton.alpha =.5;
        _nameLabel.text = @"";
    }else if(names.count == 1){
        _leftButton.alpha =.5;
        _rightButton.alpha =.5;
        _nameLabel.text = _names[0];
    }else{
        _leftButton.alpha =.5;
        _rightButton.alpha = 1;
        _nameLabel.text = _names[0];
    }
}

- (IBAction)leftButton:(UIButton *)sender {
    
    if (_names.count == 0 || _names.count == 1) {

    }else{
        if (_currentIndex > 1) {
            _leftButton.alpha = 1;
            _rightButton.alpha = 1;
            _currentIndex--;
            _nameLabel.text = _names[_currentIndex];
            if (self.selectBlock) {
                self.selectBlock(_currentIndex);
            }
        }else if (_currentIndex == 1){
            _leftButton.alpha = .5;
            _rightButton.alpha = 1;
            _currentIndex--;
            _nameLabel.text = _names[_currentIndex];
            if (self.selectBlock) {
                self.selectBlock(_currentIndex);
            }
        }else{
            
        }
    }
}

- (IBAction)rightButton:(UIButton *)sender {
    
    if (_names.count == 0 || _names.count == 1) {

    }else{
        
        if (_currentIndex == _names.count - 1) {
            
        }else if (_currentIndex == _names.count - 2){
            _leftButton.alpha = 1;
            _rightButton.alpha = .5;
            _currentIndex++;
            _nameLabel.text = _names[_currentIndex];
            if (self.selectBlock) {
                self.selectBlock(_currentIndex);
            }
        }else{
            _leftButton.alpha = 1;
            _rightButton.alpha = 1;
            _currentIndex++;
            _nameLabel.text = _names[_currentIndex];
            if (self.selectBlock) {
                self.selectBlock(_currentIndex);
            }
        }
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
