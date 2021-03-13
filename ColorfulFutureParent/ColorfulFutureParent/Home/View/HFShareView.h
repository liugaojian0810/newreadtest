//
//  HFShareView.h
//  ColorfulFuturePrincipal
//
//  Created by ql on 2020/6/2.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFShareView : UIView
- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bottomBgv;
@property(nonatomic,copy)void(^shareClickBlock)(NSInteger type);//0-3 朋友圈、微信、生成海报、赋值链接
@property(nonatomic,copy)void(^cancelClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
