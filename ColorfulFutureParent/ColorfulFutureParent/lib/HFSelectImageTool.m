//
//  HFSelectImageTool.m
//  ColorfulFutureTeacher_iOS
//
//  Created by liugaojian on 2020/6/3.
//  Copyright © 2020 huifan. All rights reserved.
//

#import "HFSelectImageTool.h"

@interface HFSelectImageTool()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation HFSelectImageTool


- (void)selectSinglePhotoFromController:(UIViewController *)currentController complete:(SelectSinglePhotoBlock)selectSinglePhotoBlock{
    
    self.fromController = currentController;
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"选择照片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(currentController)weakController = currentController;
    __weak typeof (self)weakSelf = self;
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakController)strongController = weakController;
        __strong typeof(weakSelf)strongSelf = weakSelf;
        //======判断 访问相机 权限是否开启=======
        AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
            //====没有权限====
            [strongSelf openPhotoJurisdictionOrNotWithController:strongController];
        }else{  //===有权限======
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = strongSelf;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [strongController presentViewController:picker animated:YES completion:nil];
            self.selectSignlePhoto = [selectSinglePhotoBlock copy];
        }
    }];
    UIAlertAction * photoLibraryAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakController)strongController = weakController;
        __strong typeof(weakSelf)strongSelf = weakSelf;
        //======判断 访问相册 权限是否开启=======
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        //有被授权访问的照片数据   用户已经明确否认了这一照片数据的应用程序访问
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //====没有权限====
           [strongSelf openPhotoJurisdictionOrNotWithController:strongController];
        }else{    //====有访问相册的权限=======
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [strongController presentViewController:picker animated:YES completion:nil];
            self.selectSignlePhoto = [selectSinglePhotoBlock copy];
        }
    }];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:cameraAction];
    [alertC addAction:photoLibraryAction];
    [alertC addAction:cancleAction];
    
    
    if ([self currentDeviceType] == UIUserInterfaceIdiomPad) {
        
        [alertC.popoverPresentationController setPermittedArrowDirections:0];//去掉arrow箭头
        alertC.popoverPresentationController.sourceView = currentController.view;
        alertC.popoverPresentationController.sourceRect= CGRectMake(0, currentController.view.frame.size.height, currentController.view.frame.size.width, currentController.view.frame.size.height);
        [currentController presentViewController:alertC animated:YES completion:nil];

    }else{
        
        [currentController presentViewController:alertC animated:YES completion:nil];
    }
    
//    [currentController presentViewController:alertC animated:YES completion:nil];
}

- (void)openPhotoJurisdictionOrNotWithController:(UIViewController *)currentController{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"应用相册权限受限,请在设置->隐私->相册开启权限" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    __weak typeof(self) weakSelf = self;
    UIAlertAction * openActin = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf openJurisdiction];
    }];
    [alertC addAction:cancleAction];
    [alertC addAction:openActin];
    [currentController presentViewController:alertC animated:YES completion:nil];
    
}
#pragma mark-------去设置界面开启权限----------
-(void)openJurisdiction{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (self.selectSignlePhoto) {
        self.selectSignlePhoto(image);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc{
    NSLog(@"%@  被销毁了", NSStringFromClass([self class]));
}

-(UIUserInterfaceIdiom)currentDeviceType{
    if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad){
        return UIUserInterfaceIdiomPad;
    }else{
        return UIUserInterfaceIdiomPhone;
    }
}

@end
