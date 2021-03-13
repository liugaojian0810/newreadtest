//
//  HFCacheCleanView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFCacheCleanView.h"
#import "NSString+RichString.h"
#import "UIView+HFDottedLine.h"
#import <JKCategories/JKCategories.h>
#import <SDWebImage/SDImageCache.h>
#import <mach/mach.h>

@implementation HFCacheCleanView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self showSpace];
    [UIView drawLineOfDashByCAShapeLayer:self.lineView lineLength:3 lineSpacing:1 lineColor:[UIColor jk_colorWithHexString:@"#CCBFBC"]];
}
- (IBAction)saveAction:(UIButton *)sender {

    if (self.block) {
        self.block();
    }
}

-(void)clearCache:(NSString *)path {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [self showSpace];
    [MBProgressHUD showMessage:@"清理缓存成功"];
}

- (void)showSpace{
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000.00/1000.00;
    //已用空间
    self.space.text = [NSString stringWithFormat:@"%.1fMB",([self memoryUsage]/1000/1000+MBCache)];
    //缓存
    self.cache.text = [NSString stringWithFormat:@"%.1fMB",MBCache];
  
}

//计算物理内存
- (int64_t)memoryUsage {
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
        NSLog(@"Memory in use (in bytes): %lld", memoryUsageInByte);
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kernelReturn));
    }
    return memoryUsageInByte;
}












@end
