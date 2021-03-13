//
//  HFFeedbackView.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/8.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFFeedbackView.h"
#import "HFFeedbackCollectionViewCell.h"

@implementation HFFeedbackView

-(void)awakeFromNib {
    [super awakeFromNib];
    self.feesbackCollectionView.delegate = self;
    self.feesbackCollectionView.dataSource = self;
    [self.feesbackCollectionView registerNib:[UINib nibWithNibName:@"HFFeedbackCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    self.feesbackCollectionView.bounces = NO;
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:[UIImage imageNamed:@"pic-input"]];
    [self.feesbackCollectionView reloadData];
    for (UIButton *but in self.typeBut) {
        [but setImage:[UIImage imageNamed:@"icon-weixuanzhong"] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:@"icon-xuanzhong"] forState:UIControlStateSelected];
    }
}

- (IBAction)suggestTypeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)btnAction:(UIButton *)sender {
    UIButton *select1 = self.feedbackBtnArr.firstObject;
    UIButton *select2 = self.feedbackBtnArr.lastObject;
    if (sender.tag == 0) {
        select1.selected = YES;
        select2.selected = NO;
    } else {
        select1.selected = NO;
        select2.selected = YES;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArray.count > 3) {
        return 3;
    } else {
        return self.dataArray.count;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(96, 86);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HFFeedbackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.imgView.image = self.dataArray[indexPath.row];
    __weak HFFeedbackView *weakSelf = self;
    cell.deleteBlock = ^{
        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
        [weakSelf.feesbackCollectionView reloadData];
    };
    if (self.dataArray.count == indexPath.row+ 1) {
        cell.closeBtn.hidden = YES;
    } else {
        cell.closeBtn.tag =indexPath.row;
        cell.closeBtn.hidden = NO;
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == indexPath.row +1) {
        [self.delegate feedbackAddImage:indexPath.row];
    }else {
//        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
//        browser.currentImageIndex = indexPath.row;
//        browser.sourceImagesContainerView = self;
//        browser.imageCount = self.dataArray.count-1;
//        browser.delegate = self;
//        [browser show];
    }
}


//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    if (self.dataArray.count == 1) {
//        HFFeedbackCollectionViewCell *cell = self.feesbackCollectionView.visibleCells[1];
//        UIImageView *imageView = cell.image;
//        return imageView.image;
//    } else {
//        HFFeedbackCollectionViewCell *cell = self.feesbackCollectionView.visibleCells[index];
//        UIImageView *imageView = cell.image;
//        return imageView.image;
//    }
//
//}


- (IBAction)summitAction:(id)sender {
}
@end
