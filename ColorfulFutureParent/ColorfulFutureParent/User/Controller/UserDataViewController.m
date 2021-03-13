//
//  UserDataViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "UserDataViewController.h"
#import "UserDataTableViewCell.h"
#import "TLMenuButtonView.h"
#import "HFInteractStatusListViewController.h"
#import "HFUserFamilyEditTableViewCell.h"
#import "HFSelectTimeViewController.h"
#import "HFInteractiveStatusListViewController.h"
#import "HFBabyDataModel.h"
#import "HFChangeBabyHeaderImageView.h"
#import "customHeader.h"
#import "HFAddPresentViewController.h"
#import <JKCategories/JKCategories.h>
#import <SDWebImage.h>
#import <Masonry/Masonry.h>

@interface UserDataViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _ISShowMenuButton;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UITableView *userDataTableView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong) TLMenuButtonView *tlMenuView ;
@property (nonatomic, assign) BOOL isFamilyEdit;
@property (nonatomic, strong)HFBabyDataModel *dataModel;
@property (nonatomic, strong)HFChangeBabyHeaderImageView *changeImageView;
@property (nonatomic, assign)NSInteger ImageRow;

@end

@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"宝宝信息";
    _ISShowMenuButton = NO;
    self.userDataTableView.dataSource = self;
    self.userDataTableView.delegate = self;
    [self.userDataTableView registerNib:[UINib nibWithNibName:@"UserDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"userDataCell"];
    [self.userDataTableView registerNib:[UINib nibWithNibName:@"HFUserFamilyEditTableViewCell" bundle:nil] forCellReuseIdentifier:@"editCell"];
    [self babyData];
    self.isFamilyEdit = NO;
    NSString *babyID = [[HFUserManager sharedHFUserManager] getUserInfo].babyInfo.babyID;
    [Service postWithUrl:GetChildInfoAPI params:@{ @"id": babyID} success:^(id responseObject) {
        NSError *error;
        self.dataModel = [HFBabyDataModel fromJSON:[responseObject jk_JSONString] encoding:4 error:&error];
        [self.userDataTableView reloadData];
//        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:self.dataModel.model.photo] placeholderImage:[UIImage imageNamed: self.dataModel.model.sex == 1 ? @"header_girl" : @"header_boy"]];
//        self.name.text = self.dataModel.model.name;
    } failure:^(HFError *error) {
        
    }];
    //更换宝宝头像
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
//    [self.headerImage addGestureRecognizer:tapGesture];
//    self.headerImage.userInteractionEnabled = YES;
    self.headerImage.layer.borderWidth = 1;
    self.headerImage.layer.borderColor = [UIColor jk_colorWithHexString:@"#915322"].CGColor;
    self.changeImageView = [[NSBundle mainBundle]loadNibNamed:@"HFChangeBabyHeaderImageView" owner:nil options:nil].firstObject;
    self.changeImageView.frame = self.view.frame;
    WS(weakSelf);
    self.changeImageView.block = ^(NSInteger tag) {
        [UIView animateWithDuration:1 animations:^{
        //0为相册选取1为拍照其他为关闭
        [weakSelf changeBabyHeaderImage:tag];
        weakSelf.changeImageView.transform = CGAffineTransformMakeTranslation(0, HFCREEN_WIDTH);
        }];
    };
    [self.view addSubview:self.changeImageView];
    self.changeImageView.transform = CGAffineTransformMakeTranslation(0, HFCREEN_WIDTH);
    //相册返回通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAssetsData:) name:@"PhotoAssets" object:nil];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)babyData {
    [self.dataArr removeAllObjects];
    for (int i = 0; i < 6; i++) {
        switch (i) {
            case 0:
                [self.dataArr addObject:@{@"姓名":@"宝宝"}];
                break;
            case 1:
                [self.dataArr addObject:@{@"性别":@"女"}];
                break;
            case 2:
                [self.dataArr addObject:@{@"出生日期":@"2015年01月13日"}];
                break;
            case 3:
                [self.dataArr addObject:@{@"所属幼儿园":@"请为宝宝添加幼儿园"}];
                break;
            case 4:
                [self.dataArr addObject:@{@"所属班级":@"小1班"}];
                break;
            default:
//                [self.dataArr addObject:@{@"家庭成员":@"爸爸"}];
                break;
        }
    }
}

- (void)changeBabyHeaderImage:(NSInteger)status {
    __block  NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    if (status == 1) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){//无权限
            //去设置相机权限
            UIAlertController *settingalertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"您的相机权限尚未开启,请前去设置-隐私-相机中开启相机权限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
            [settingalertController addAction:cancelAction];
            [self presentViewController:settingalertController animated:YES completion:nil];
        } else {
            // 判断是否支持相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            // 跳转到相机或相册页面
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;//是否裁剪原图
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:^{ }];
        }
    } else if (status == 0) {
        [UserData1 userDataStandard].photoNumber = 1;
        [UserData1 userDataStandard].photoMaxNumber = 1;
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusDenied) {//用户拒绝访问
                UIAlertController *settingalertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"您的相册权限尚未开启,是否前去设置-隐私-照片中开启相册权限?" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//去设置相册权限
                    NSURL *setingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:setingsURL]) {     [[UIApplication sharedApplication] openURL:setingsURL];
                    }
                }];
                [settingalertController addAction:cancelAction];
                [settingalertController addAction:okAction];
                [self presentViewController:settingalertController animated:YES completion:nil];
            } else {//允许访问相册
                // 获得所有的自定义相簿
                PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
                // 遍历所有的自定义相簿
                NSMutableArray *arr = [NSMutableArray array];
                if (assetCollections.count > 0) {
                    for (PHAssetCollection *assetCollection in assetCollections) {
                        PHFetchResult<PHAsset *> *assets1 = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
                        NSDictionary *dic = @{@"title":assetCollection.localizedTitle,@"assets":assets1,@"count":[NSString stringWithFormat:@"%ld",assets1.count]};
                        [arr addObject:dic];
                    }
                }
                // 获得相机胶卷,  estimatedAssetCount这个属性,在自定义相册里面返回的照片数是正确的,在相机胶圈中,返回的是不正确的
                PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
                // 获得某个相簿中的所有PHAsset对象
                PHFetchResult<PHAsset *> *assets2 = [PHAsset fetchAssetsInAssetCollection:cameraRoll options:nil];
                if (cameraRoll != nil) {
                    [arr addObject:@{@"title":cameraRoll.localizedTitle,@"assets":assets2,@"count":[NSString stringWithFormat:@"%ld",assets2.count]}];
                }
                if (cameraRoll != nil) {
                    SeleceAlbumViewController *seleVC = [[SeleceAlbumViewController alloc]init];
                    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:seleVC];
                    seleVC.dataArray = [arr copy];
                    [UserData1 userDataStandard].isSeleceArray = [NSMutableArray array];
                    [UserData1 userDataStandard].photoAssets = [NSMutableArray array];
                    [self presentViewController:navc animated:YES completion:nil];
                } else {
                    NSLog(@"请先授权相册权限,授权之后再次点击");
                }
            }
    }
}

//暂时不做切换宝宝
//-(void)setBabyInfo
//{
//    self.name.text = [NSString stringWithFormat:@"%@",self.infoDict[@"name"]];
////    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
////    self.headerImage.backgroundColor = [UIColor yellowColor];
//    self.headerImage.layer.masksToBounds = YES;
//    self.headerImage.layer.cornerRadius = self.headerImage.frame.size.height/2;

//
//    TLMenuButtonView *tlMenuView =[TLMenuButtonView standardMenuView];
//
//    tlMenuView.centerPoint = self.view.center;
//    __weak typeof(self) weakSelf = self;
//    tlMenuView.clickAddButton = ^(NSInteger tag, UIColor *color){
//        weakSelf.view.backgroundColor = color;
//        _ISShowMenuButton = YES;
//        [weakSelf clickImage:self.headerImage];
//    };
//    _tlMenuView = tlMenuView;
//
//}

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 5) {
        return 35;
    } else {
//        return 35 *self.dataModel.model.parentsInfoVOS.count;
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count+ 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);

    
    if (indexPath.row < 5) {//宝宝基本信息
        UserDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userDataCell"];
        cell.eidtBut.tag = indexPath.row;
        cell.block = ^(NSInteger row) {
            [weakSelf updateBabydata:row];
        };
        [cell updataBaby:self.dataArr[indexPath.row] with:indexPath.row with:self.dataModel.model];

        return cell;
    } else {//宝宝家长
        HFUserFamilyEditTableViewCell *editCell = [tableView dequeueReusableCellWithIdentifier:@"editCell"];
        [editCell updatePresentWith:self.dataModel.model];
        editCell.block = ^{
            [weakSelf addPresent];
        };
        return editCell;
    }
}


//更新宝宝信息
- (void)updateBabydata:(NSInteger)status {
    switch (status) {
        case 1:
        {
            HFSelectTimeViewController *VC = [HFSelectTimeViewController new];
            VC.gemsTimeArr = @[@"男",@"女"];
            VC.block = ^(NSString * _Nonnull string) {
                HFLog(@"%@",string);
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
            break;
        case 2:
        {
            HFSelectTimeViewController *VC = [HFSelectTimeViewController new];
            VC.statusNum = 1;
            VC.block = ^(NSString * _Nonnull string) {
                HFLog(@"%@",string);
            };
            [self presentViewController:VC animated:YES completion:nil];
        }
            
            break;

    }
}
//添加父母
-(void)addPresent {
    HFAddPresentViewController *VC = [HFAddPresentViewController new];
    VC.block = ^(NSDictionary * _Nonnull dic) {
        
    };
    [self presentViewController:VC animated:NO completion:nil];
}

#pragma mark - 点击头像 弹出扇形按钮
-(void)clickImage:(id)sender
{

    [UIView animateWithDuration:1 animations:^{
        self.changeImageView.transform = CGAffineTransformIdentity;
    }];


//    if (!_ISShowMenuButton) {
////           [UIView animateWithDuration:0.2 animations:^{
////               CGAffineTransform rotate = CGAffineTransformMakeRotation( M_PI / 4 );
////               [sender setTransform:rotate];
////           }];
//           [_tlMenuView showItems];
//       }else{
////           [UIView animateWithDuration:0.2 animations:^{
////               CGAffineTransform rotate = CGAffineTransformMakeRotation( 0 );
////               [sender setTransform:rotate];
////           }];
//           [_tlMenuView dismiss];
//       }
//       _ISShowMenuButton = !_ISShowMenuButton;
}

//-(void)back
//{
//    if (_ISShowMenuButton == YES) {
//        __weak typeof(self) weakSelf = self;
//        [weakSelf clickImage:self.headerImage];
//    }
//
//    [self dismissViewControllerAnimated:NO completion:nil];
//}


//获得通知里面的数据
- (void)getAssetsData:(NSNotification *)Info
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.networkAccessAllowed = NO;
        //PHImageManagerMaximumSize为原图尺寸, 可以自定义尺寸CGSizeMake(180, 180)
        if ([Info.userInfo[@"assetsArray"] count] > 0) {
            for (int i = 0; i < [Info.userInfo[@"assetsArray"] count]; i++) {
                PHAsset *asset = Info.userInfo[@"assetsArray"][i];
                CGFloat scaleWidth;
                CGFloat scaleHeight;
                if (asset.pixelWidth > Width_Screen *2) {
                    scaleWidth = asset.pixelWidth *0.5/ Width_Screen;
                    scaleHeight = asset.pixelHeight*0.5/ Height_Screen;
                } else {
                    scaleWidth = asset.pixelWidth *0.9/ Width_Screen;
                    scaleHeight = asset.pixelHeight*0.9/ Height_Screen;
                }
                CGSize size11;
                if (scaleHeight >= scaleWidth){
                    size11 = CGSizeMake(asset.pixelWidth/ scaleHeight ,asset.pixelHeight / scaleHeight);
                }else{
                    size11 = CGSizeMake(asset.pixelWidth/ scaleWidth , asset.pixelHeight / scaleWidth);
                }
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size11 contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    self.headerImage.image = result;
                }];
            }
        }
    }];
    [operation start];
}

//拍照回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //UIImagePickerControllerOriginalImage 原图,  UIImagePickerControllerEditedImage 裁剪过的的图
    UIImage *croppedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGFloat scaleWidth;
    CGFloat scaleHeight;
    if (croppedImage.size.width > Width_Screen *2) {
        scaleWidth = croppedImage.size.width *0.5/ Width_Screen;
        scaleHeight = croppedImage.size.height*0.5/ Height_Screen;
    } else {
        scaleWidth = croppedImage.size.width *0.9/ Width_Screen;
        scaleHeight = croppedImage.size.height*0.9/ Height_Screen;
    }
    CGSize size11;
    if (scaleHeight >= scaleWidth){
        size11 = CGSizeMake(croppedImage.size.width/ scaleHeight ,croppedImage.size.height / scaleHeight);
    }else{
        size11 = CGSizeMake(croppedImage.size.width/ scaleWidth , croppedImage.size.height / scaleWidth);
    }
    UIGraphicsBeginImageContext(size11);
    CGRect rect = {{0,0}, size11};
    [croppedImage drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.headerImage.image = image;
    UIGraphicsEndImageContext();
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
