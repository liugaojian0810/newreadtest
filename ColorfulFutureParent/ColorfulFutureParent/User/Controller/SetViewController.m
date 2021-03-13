//
//  SetViewController.m
//  ColorfulFutureParent
//
//  Created by 仵争争 on 2020/5/7.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "SetViewController.h"
#import "HFHintViewController.h"
#import "HFCacheCleanView.h"
#import "HFVisionUpdateView.h"
#import "HFFeedbackView.h"
#import "customHeader.h"
#import "HFInteractiveStatusListViewController.h"
#import "HFMyViewModel.h"
#import "HomeViewController.h"
static NSInteger maxNumber = 3;//能选择的最大照片数量(包括拍照和相册选择的)

@interface SetViewController ()<feedbackDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnAarr;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *authCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIView *setBackView;
@property (nonatomic, strong)HFCacheCleanView *cacheCleanView;
@property (nonatomic, strong)HFVisionUpdateView *visionUpdateView;
@property (nonatomic, strong)HFFeedbackView *feedbackView;
@property (nonatomic, strong) NSMutableArray *titleAndAssetsArray;//下个tableview的标题和图
@property (nonatomic, assign)NSInteger ImageRow;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (nonatomic, strong)HFMyViewModel *myViewModel;
- (IBAction)getCodeAction:(id)sender;

@property (nonatomic, copy) NSString  *appVersion;
@property (nonatomic, assign) BOOL haveNewVersion;
@property (nonatomic, copy) NSString  *attach;


@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleName = @"设置";
    _myViewModel = [[HFMyViewModel alloc]init];
    
    //#warning ----------检测版本
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary  *versionMsg = [userDefaults objectForKey:@"Update_Msg"];
    NSString *versionCode =  versionMsg[@"versionCode"];
    _appVersion = versionCode;
    _attach = versionMsg[@"attach"];
    NSString *locaVersion = HFAppVersion;
    if ([locaVersion isEqualToString:self.appVersion]) {
        _haveNewVersion = NO;
    }else{
        if (versionCode != nil) {
            _haveNewVersion = YES;
        }else{
            _haveNewVersion = NO;
        }
    }
    
    
    self.cacheCleanView = [[NSBundle mainBundle]loadNibNamed:@"HFCacheCleanView" owner:nil options:nil].firstObject;
    self.cacheCleanView.frame = CGRectMake(0, 0, 335, 183);
    [self.backView addSubview:self.cacheCleanView];
    self.cacheCleanView.hidden = YES;
    __weak SetViewController *weakSelf = self;
    self.cacheCleanView.block = ^{
        HFHintViewController *VC = [[HFHintViewController alloc]init];
        VC.block = ^{
            [weakSelf.cacheCleanView clearCache:@""];
        };
        VC.massageString = @"清空临时缓存？";
        [weakSelf presentViewController:VC animated:NO completion:nil];
    };
    
    self.visionUpdateView = [[NSBundle mainBundle]loadNibNamed:@"HFVisionUpdateView" owner:nil options:nil].firstObject;
    self.visionUpdateView.frame = CGRectMake(0, 0, 335, 185);
    [self.backView addSubview:self.visionUpdateView];
    self.visionUpdateView.hidden = YES;
    WeakSelf
    self.visionUpdateView.clickBlock = ^{
        Strong_Self
        [self versionUpdateOperation];
    };
    self.visionUpdateView.versionLabel.text = [@"Version " stringByAppendingString:locaVersion];
    self.feedbackView = [[NSBundle mainBundle]loadNibNamed:@"HFFeedbackView" owner:nil options:nil].firstObject;
    self.feedbackView.frame = CGRectMake(0, 0, 335, 185);
    [self.backView addSubview:self.feedbackView];
    self.feedbackView.hidden = YES;
    self.feedbackView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAssetsData:) name:@"PhotoAssets" object:nil];
    self.cacheCleanView.hidden = NO;
    self.feedbackView.hidden = YES;
    self.visionUpdateView.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)versionUpdateOperation{
    if (self.haveNewVersion == YES) {
        HFHintViewController *VC = [[HFHintViewController alloc]init];
        VC.massageString = @"版本已升级，让你使用更流畅";
        VC.titleString = @"温馨提示";
        VC.block = ^{
            //这个时候跳转应用更新模块
            NSString * strIdentifier = self.attach;
            BOOL isExsit = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strIdentifier]];
            if(isExsit) {
                NSLog(@"App %@ installed", strIdentifier);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strIdentifier]];
            }
        };
        [self presentViewController:VC animated:NO completion:nil];
    }else{
        [MBProgressHUD showMessage:@"当前版本已是最新"];
        return;
        
        
    }
}


- (IBAction)btnAction:(UIButton *)sender {
    //0为修改密码,1为清理缓存,2为版本更新,3为问题反馈,4为退出登录
    for (int i = 0; i < self.btnAarr.count; i++) {
        UIButton * btn = self.btnAarr[i];
        if (i == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    switch (sender.tag) {
        case 0:
//            self.cacheCleanView.hidden = YES;
//            self.feedbackView.hidden = YES;
//            self.visionUpdateView.hidden = YES;
                        self.cacheCleanView.hidden = NO;
                        self.feedbackView.hidden = YES;
                        self.visionUpdateView.hidden = YES;
            break;
            
        case 1:
//            self.cacheCleanView.hidden = NO;
//            self.feedbackView.hidden = YES;
//            self.visionUpdateView.hidden = YES;
                        self.cacheCleanView.hidden = YES;
                        self.feedbackView.hidden = YES;
                        self.visionUpdateView.hidden = NO;
            break;
        case 2:
//            self.cacheCleanView.hidden = YES;
//            self.feedbackView.hidden = YES;
//            self.visionUpdateView.hidden = NO;
            
                    {
                        HFHintViewController *VC = [[HFHintViewController alloc]init];
                        VC.massageString = @"确定退出账号？";
                        VC.titleString = @"设置";
                        WeakSelf
                        VC.block = ^{
                            Strong_Self
                            [self letout];
            
                        };
                        [self presentViewController:VC animated:NO completion:nil];
                    }
            break;
        case 3:
//            self.cacheCleanView.hidden = YES;
//            self.feedbackView.hidden = NO;
//            self.visionUpdateView.hidden = YES;
            break;
            
        default:
//        {
//            HFHintViewController *VC = [[HFHintViewController alloc]init];
//            VC.massageString = @"确认退出账号吗？";
//            VC.titleString = @"设置";
//            WeakSelf
//            VC.block = ^{
//                Strong_Self
//                [self letout];
//
//            };
//            [self presentViewController:VC animated:NO completion:nil];
//        }
            break;
    }
}

-(void)letout{
    
    [_myViewModel letout];
    WeakSelf
    [[_myViewModel.fetchLetoutCommand execute:nil]subscribeError:^(NSError *error) {
        Strong_Self
        
    } completed:^{
        Strong_Self
        [self dismissViewControllerAnimated:NO completion:nil];
        [[HFUserManager sharedHFUserManager] removeUserInfo];
        [UIApplication sharedApplication].keyWindow.rootViewController = [HomeViewController new];
    }];
}

- (IBAction)saveAction:(UIButton *)sender {
}
- (IBAction)hiddenAction:(UIButton *)sender {
    if (!sender.isSelected) {
        self.password.secureTextEntry = YES;
        sender.selected = YES;
    } else {
        self.password.secureTextEntry = NO;
        sender.selected = NO;
    }
}

- (void)feedbackAddImage:(NSInteger)row {
    self.ImageRow = row;
    __weak SetViewController *weakSelf = self;
    //可以选择几张照片(拍照+选图的总数)
    if (self.feedbackView.dataArray.count-1 < maxNumber) {
        [UserData1 userDataStandard].photoNumber = maxNumber - self.feedbackView.dataArray.count+1;
        [UserData1 userDataStandard].photoMaxNumber = 3;
        UIAlertController *albumalertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        __block  NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//从相册选择
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
                [weakSelf presentViewController:settingalertController animated:YES completion:nil];
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
        }];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {//拍照
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){//无权限
                //去设置相机权限
                UIAlertController *settingalertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"您的相机权限尚未开启,请前去设置-隐私-相机中开启相机权限" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
                [settingalertController addAction:cancelAction];
                [weakSelf presentViewController:settingalertController animated:YES completion:nil];
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
                [weakSelf presentViewController:imagePickerController animated:YES completion:^{ }];
            }
        }];
        [albumalertController addAction:albumAction];
        [albumalertController addAction:photoAction];
        [albumalertController addAction:cancelAction];
        [self presentViewController:albumalertController animated:YES completion:nil];
    } else {
        //        [MGTopTipView showTopTipContent:@"您最多只能添加三张图片"];
    }
}

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
                    [self.feedbackView.dataArray insertObject:result atIndex:self.ImageRow];
                    if ([asset isEqual:[Info.userInfo[@"assetsArray"] lastObject]]) {
                        [self.feedbackView.feesbackCollectionView reloadData];
                    }
                }];
            }
        }
    }];
    [operation start];
    //    NSString *str = [[self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //
    //    if (str.length > 0 || self.dataArray.count > 1) {
    //        [self initFinishBT: NO];
    //    } else {
    //        [self initFinishBT: YES];
    //    }
}

- (void)removeImage:(NSInteger)row{
    [self.feedbackView.dataArray removeObjectAtIndex:row];
    [self.feedbackView.feesbackCollectionView reloadData];
    //    NSString *str = [[self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //    if (str.length > 0 || self.dataArray.count > 1) {
    //        [self initFinishBT: NO];
    //    } else {
    //        [self initFinishBT: YES];
    //
    //    }
}

//拍照回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.feedbackView.dataArray.count-1 < maxNumber) {
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
        UIGraphicsEndImageContext();
        [self.feedbackView.dataArray insertObject:image atIndex:self.ImageRow];
        [self.feedbackView.feesbackCollectionView reloadData];
        //        NSString *str = [[self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        //        if (str.length > 0 || self.dataArray.count > 1) {
        //            [self initFinishBT: NO];
        //        } else {
        //            [self initFinishBT: YES];
        //        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)getCodeAction:(id)sender {
}
@end
