//
//  HFMyViewModel.h
//  ColorfulFutureTeacher_iOS
//
//  Created by 刘高见 on 2020/5/23.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFUpdateModel.h"
#import "HFBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFMyViewModel : HFBaseViewModel


@property (nonatomic,strong)RACCommand* fetchGetVersionCommand;
@property (nonatomic,strong)RACCommand* fetchLetoutCommand;


@property(nonatomic, strong)HFUpdateModel *updateModel;


-(void)getVersion;
-(void)letout;


@end

NS_ASSUME_NONNULL_END
