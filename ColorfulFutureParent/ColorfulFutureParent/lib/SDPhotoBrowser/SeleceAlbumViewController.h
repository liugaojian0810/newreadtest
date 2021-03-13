//
//  SeleceAlbumViewController.h
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeleceAlbumViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
