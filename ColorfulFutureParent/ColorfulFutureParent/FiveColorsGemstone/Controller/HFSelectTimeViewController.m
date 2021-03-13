//
//  HFSelectTimeViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/9.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFSelectTimeViewController.h"
#import <JKCategories/JKCategories.h>

@interface HFSelectTimeViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *timePickView;
@property (nonatomic, strong)NSString *timeString;
@property (nonatomic, strong)NSString *timeString1;
@property (nonatomic, strong)NSString *timeString2;
@property (nonatomic, strong)NSMutableArray *yearArr;
@property (nonatomic, strong)NSMutableArray *monthArr;
@property (nonatomic, strong)NSMutableArray *dayArr;

@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation HFSelectTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timePickView.delegate = self;
    self.timeString = @"2018年";
    self.timeString1 = @"1月";
    for (int i = 2000; i< 2020; i++) {
        NSString *year = [NSString stringWithFormat:@"%d年",i];
        [self.yearArr addObject:year];
    }
    for (int i = 1; i < 13; i++) {
        NSString *month = [NSString stringWithFormat:@"%d月",i];
        [self.monthArr addObject:month];
    }
    for (int i = 1; i < 32; i++) {
        NSString *day = [NSString stringWithFormat:@"%d日", i];
        [self.dayArr addObject:day];
    }
}

- (IBAction)leftAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)rightAction:(UIButton *)sender {
    if (self.statusNum == 1) {//日期
        if (self.block) {
            self.block([NSString stringWithFormat:@"%@%@%@",self.timeString,self.timeString1, self.timeString2]);
        } else {
            self.block(self.timeString);
        }
    }

}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    if (self.statusNum == 1) {
        return 3;
    } else {
        return 1;
    }
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.statusNum == 1) {
        if (component == 0) {
            return self.yearArr.count;
        } else if (component == 1) {
            return self.monthArr.count;
        } else {
            NSInteger num = [pickerView selectedRowInComponent:0]%4;
            NSInteger month = [pickerView selectedRowInComponent:1];
            if (month == 0|| month == 2 || month == 4 || month == 6 || month == 7 || month == 9 || month == 11) {
                return 31;
            } else if (month == 3|| month == 5 || month == 8 || month == 10) {
                return 30;
            } else {
                if (num == 0) {
                    return 29;
                } else {
                    return 28;
                }
            }
        }
    } else {
        
        return self.gemsTimeArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.statusNum == 1) {
        if (component == 0) {
            return self.yearArr[row];
        } else if (component == 1) {
            return self.monthArr[row];
        } else {
            NSInteger num = [pickerView selectedRowInComponent:0]%4;
            NSInteger month = [pickerView selectedRowInComponent:1];
            NSInteger day = [pickerView selectedRowInComponent:2];
            if (month == 0|| month == 2 || month == 4 || month == 6 || month == 7 || month == 9 || month == 11) {
                
                return self.dayArr[row];
            } else if (month == 3|| month == 5 || month == 8 || month == 10) {
                if (day >= 30) {
                    return self.dayArr[29];
                }else {
                    return self.dayArr[row];
                }
            } else {
                if (num == 0) {
                    if (row >= 28) {
                        return self.dayArr[28];
                    } else {
                        return self.dayArr[row];
                    }
                } else {
                    if (row >= 27) {
                        return self.dayArr[27];
                    } else {
                        return self.dayArr[row];
                    }
                }
            }
        }
    } else {
        return self.gemsTimeArr[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.statusNum == 1) {
        if (component == 1) {
            self.timeString1 = self.monthArr[row];

            NSInteger num = [pickerView selectedRowInComponent:0]%4;
            NSInteger month = [pickerView selectedRowInComponent:1];
            NSInteger day = [pickerView selectedRowInComponent:2];
            if (month == 0|| month == 2 || month == 4 || month == 6 || month == 7 || month == 9 || month == 11) {
                [pickerView reloadComponent:2];
            } else if (month == 3|| month == 5 || month == 8 || month == 10) {
                [pickerView reloadComponent:2];
                if (day >= 30) {
                    [pickerView selectRow:29 inComponent:2 animated:YES];
                }
            } else {
                [pickerView reloadComponent:2];
                if (num == 0) {
                    if (row >= 28) {
                        [pickerView selectRow:27 inComponent:2 animated:YES];
                    }
                } else {
                    if (row >= 27) {
                        [pickerView selectRow:26 inComponent:2 animated:YES];
                        [pickerView reloadComponent:2];
                    }
                }
            }
        } else if (component == 0) {
            self.timeString = self.yearArr[row];
            [pickerView reloadComponent:2];
        } else {
            self.timeString2 = self.dayArr[row];
        }
    } else {
        self.timeString = self.gemsTimeArr[row];
    }

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
     UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.font = [UIFont systemFontOfSize:16];
        [pickerLabel setTextColor:[UIColor jk_colorWithHexString:@"#999999"]];
    }
    UIView *view1 = [pickerView viewForRow:row forComponent:component];
        if ([view1 isKindOfClass:[UILabel class]]) {
            UILabel * label = (UILabel *)view1;
            label.textColor = [UIColor jk_colorWithHexString:@"#FF8D00"];
        }
    for (UIView *view in pickerView.subviews) {
        if (view.frame.size.height < 1) {
            view.backgroundColor = [UIColor jk_colorWithHexString:@"#F2F2F2"];
        }
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSMutableArray *)yearArr {
    if (_yearArr == nil) {
        _yearArr = [NSMutableArray array];
    }
    return _yearArr;
}

- (NSMutableArray *)monthArr {
    if (_monthArr == nil) {
        _monthArr = [NSMutableArray array];
    }
    return _monthArr;
}

- (NSMutableArray *)dayArr {
    if (_dayArr == nil) {
        _dayArr = [NSMutableArray array];
    }
    return _dayArr;
}

@end
