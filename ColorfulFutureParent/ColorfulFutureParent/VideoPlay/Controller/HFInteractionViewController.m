//
//  HFInteractionViewController.m
//  ColorfulFutureParent
//
//  Created by Mac on 2020/5/12.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFInteractionViewController.h"
#import "HFInteractionItem.h"
#import "HFGetAnswer.h"
#import "HFAudioPlayer.h"
#define  ANSWERCONTEXTRIGHT @"回答正确，获得%ld颗宝石"
#define  ANSWERCONTEXTWRONG @"回答错误，获得%ld颗宝石"

@interface HFInteractionViewController ()
@property(nonatomic, strong) NSArray<NSString *> *arrayItemsURL;
@property(nonatomic, strong) NSMutableArray<HFInteractionItem *> *arrayItems;
@property(nonatomic, strong) UIButton *btnClose;
@property(nonatomic, strong) UILabel *questLab, *answerContext;
@property(nonatomic, strong) UIImageView *resultIMG;
@property(nonatomic, assign) NSInteger answer;
@property(nonatomic, strong) HFGetAnswer *getAnswerModel;
@property (nonatomic, assign) BOOL isFinish;//防止重复请求
@end

@implementation HFInteractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFinish = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.48];
}

-(void)addMySubViews {
    for (HFQequestModel *temp in self.questionList.list) {
        HFInteractionItem *item = [HFInteractionItem new];
        [self.view addSubview: item];
        item.tag = temp.identifier;
        item.itemIMGURL = temp.title;
        item.isSelected = NO;
        [self.arrayItems addObject:item];
        if (temp.isRealanswer == 1) {
            self.answer = temp.identifier;
        }
    }
    [self.view addSubview: self.btnClose];
    [self.view addSubview: self.questLab];
}

-(void)setQuestion:(NSString *)question {
    _question = question;
    self.questLab.text = _question;
}

-(void)setQuestionList:(HFRequestionList *)questionList {
    _questionList = questionList;
    
    [self addMySubViews];
    [self setMasonry];
    [self addTarget];
}

-(void)setMasonry {
    BOOL isiphoneX = HFIsiPhoneX;
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40.0);
        make.left.mas_equalTo(isiphoneX ? 60.0 : 20.0);
        make.top.mas_equalTo(20.0);
    }];
    NSUInteger itemsCount = self.questionList.list.count;//self.arrayItems.count;
    if (itemsCount > 3) {
        CGFloat centerx = 150;
        for (int i = 0; i < itemsCount; i++) {
            HFInteractionItem *item = self.arrayItems[i];

            CGFloat centerxOffset = (i - 1) * centerx - 60;
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.view);
                make.centerX.mas_equalTo(self.view).offset(centerxOffset);
                make.width.mas_equalTo(140.0);
                make.height.mas_equalTo(164.0);
            }];
        }
    } else {
        CGFloat centerx = itemsCount == 2 ? 100 : 150;
        for (int i = 0; i < itemsCount; i++) {
            HFInteractionItem *item = self.arrayItems[i];
            
            CGFloat centerxOffset = (i * (itemsCount == 2 ? 2 : 1) - 1) * centerx;
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.view);
                make.centerX.mas_equalTo(self.view).offset(centerxOffset);
                make.width.mas_equalTo(140.0);
                make.height.mas_equalTo(164.0);
            }];
        }
    }
    [self.questLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(110);
    }];
}

-(void)addTarget {
    for (HFInteractionItem *item in self.arrayItems) {
        __weak typeof(self) weakSelf = self;
        __weak typeof(item) weakItem = item;
        [item setTapActionWithBlock:^{
            [weakSelf itemClick: weakItem];
        }];
    }
}

-(void)itemClick:(HFInteractionItem *) item {
    for (HFInteractionItem *itemTemp in self.arrayItems) {
        itemTemp.isSelected = [itemTemp isEqual:item];
    }
    
    if (!self.isFinish) {
        return;
    }
    self.isFinish = NO;
    NSMutableDictionary *dictParams = [NSMutableDictionary dictionary];
    NSString *babyId = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [dictParams setValue: babyId forKey:@"babyId"];
    [dictParams setValue: self.courseId forKey: @"courseId"];
    [dictParams setValue: @(self.questionList.identifier) forKey:@"questionsId"];
    [dictParams setValue: @(item.tag) forKey: @"isRealanswerId"];
    [dictParams setValue: self.playType forKey: @"playType"];
    [dictParams setValue: @"1" forKey: @"interactType"];
    [dictParams setValue: @"0" forKey:@"decibels"];
    [dictParams setValue: self.weekDetailId forKey:@"weekDetailId"];

    [Service postWithUrl:GetAnswerAPI params:dictParams success:^(id responseObject) {
        HFLog(@"responseObject:%@",responseObject);
        NSError *error;
        self.getAnswerModel = [HFGetAnswer fromJSON:[responseObject jk_JSONString] encoding:4 error: &error];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (HFInteractionItem *itemTemp in self.arrayItems) {
                [itemTemp setHidden:YES];
            }
            
            [self.view addSubview: self.resultIMG];
            if (self.getAnswerModel.model.isFlag) {
                self.answerContext.text = self.getAnswerModel.model.currentNum > 0 ? [NSString stringWithFormat:@"%ld颗", (long)self.getAnswerModel.model.currentNum] : @"你真棒！";
                HFAudioPlayer *audio = [HFAudioPlayer new];
                [audio playWithName:@"voice_good.mp3"];
            } else {
                HFAudioPlayer *audio = [HFAudioPlayer new];
                [audio playWithName:@"voice_keep_going.mp3"];
                
                self.answerContext.text = self.getAnswerModel.model.currentNum > 0 ? [NSString stringWithFormat:@"%ld颗", (long)self.getAnswerModel.model.currentNum] : @"加油哦~";
            }
            [self.resultIMG mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.view);
            }];
            [self.view addSubview: self.answerContext];
            [self.answerContext mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.resultIMG);
                make.bottom.mas_equalTo(self.resultIMG.mas_top);
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self btnCloseClick];
            });
        });
        self.isFinish = YES;
    } failure:^(HFError *error) {
        HFLog(@"error:%@",error);
        self.isFinish = YES;
    }];
}

-(void)btnCloseClick {
    
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.backBlock) {
            self.backBlock();
        }
    }];
}

-(NSArray<NSString *> *)arrayItemsURL {
    
    if (nil == _arrayItemsURL) {
        _arrayItemsURL = @[];
    }
    return _arrayItemsURL;
}

-(NSMutableArray<HFInteractionItem *> *)arrayItems {
    if (nil == _arrayItems) {
        _arrayItems = [NSMutableArray array];
    }
    return _arrayItems;
}

-(UIButton *)btnClose {
    if (nil == _btnClose) {
        _btnClose = [UIButton new];
        [_btnClose setBackgroundImage:[UIImage imageNamed:@"base_left_back"] forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}

-(UILabel *)questLab {
    if (nil == _questLab) {
        _questLab = [UILabel new];
        _questLab.textColor = [UIColor jk_colorWithHexString:@"#FFC50F"];
        _questLab.font = [UIFont boldSystemFontOfSize:18];
    }
    return _questLab;
}

-(UIImageView *)resultIMG {
    if (nil == _resultIMG) {
        _resultIMG = [UIImageView new];
        _resultIMG.image = [UIImage imageNamed:@"ic_zhengque"];
    }
    return _resultIMG;
}

-(UILabel *)answerContext {
    if (nil == _answerContext) {
        _answerContext = [UILabel new];
        _answerContext.textColor = [UIColor whiteColor];
        _answerContext.font = [UIFont boldSystemFontOfSize:28];
        
    }
    return _answerContext;
}

@end
