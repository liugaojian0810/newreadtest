//
//  HFPosterView.h
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPosterView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImage;
@property (weak, nonatomic) IBOutlet UIView *shareView;
- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *presenter;
@property (weak, nonatomic) IBOutlet UILabel *cardname;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UIImageView *lessonImage;

@property(nonatomic,copy)void(^btnBlock)(NSInteger index);

@property (nonatomic,assign) NSInteger type; //0以柒彩未来身份 1.以园长身份
@end

NS_ASSUME_NONNULL_END
