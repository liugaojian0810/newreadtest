//
//  Service.m
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

#import "Service.h"
#import "ServiceFactory.h"
#import "HFConfig.h"
#import "HomeViewController.h"

static NSString *kServiceMimeType         = @"image/jpeg";
static NSString *kServiceDateFormat       = @"yyyyMMddHHmmss";
static NSString *kServiceTimeoutInterval  = @"timeoutInterval";


@interface Service ()


@end

@implementation Service


+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return manager;
}

/** 图片管理者因为序列化的问题，暂不用单例 */
+ (AFHTTPSessionManager *)imageManager {
    AFHTTPSessionManager *imageManager = [AFHTTPSessionManager manager];
    imageManager.requestSerializer = [AFJSONRequestSerializer serializer];
    imageManager.responseSerializer = [AFImageResponseSerializer serializer];
    [imageManager setValue:[ServiceFactory baseURL] forKey:NSStringFromSelector(@selector(baseURL))];
    return imageManager;
}

/** 设置请求管理者 */
+ (void)setupServiceManagerWithUrl:(NSString *)url
                            params:(id)params
                            method:(HTTPRequestMethod)method {
    //切换环境
//    [ServiceFactory changeEnvironmentType:EnvironmentTypeRelease];
    
    //切换环境
    #ifdef DEBUG
    //[ServiceFactory changeEnvironmentType:EnvironmentTypeRelease];
    #else
        [ServiceFactory changeEnvironmentType:EnvironmentTypeRelease];
    #endif
    
    [ServiceManager setValue:[ServiceFactory baseURL] forKey:NSStringFromSelector(@selector(baseURL))];

//    [ServiceFactory changeEnvironmentType:EnvironmentTypeDevelop];
    // 设置响应序列化格式为JSON
    ServiceManager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置请求头参数
    //    NSString *token = @"03498997b1884f68b8286dcdbcacfae9";
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:UserToken];
    if (token.length) {
        [ServiceManager.requestSerializer setValue:token  forHTTPHeaderField:@"token"];
    }
    [ServiceManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[UIDevice jk_version]]  forHTTPHeaderField:@"version"];
    
    [ServiceManager setValue:[ServiceFactory baseURL] forKey:NSStringFromSelector(@selector(baseURL))];
    
    ServiceManager.requestSerializer.timeoutInterval = 30.f;
    
    // 显示网络指示器加载状态（UI API called from background thread Group）
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
    NSString *absurl = nil;
    if (HTTPRequestMethodGET == method) {
        absurl = [[ServiceFactory getCurrentBaseAPI] stringByAppendingString:[HFConfig serializedWithURIString:url params:params]];
         HFLog(@"\n\
         ---------------------------- BEGIN Service --------------------------------\n\
         method: %@ \n\
         token: %@ \n\
         absurl: %@ \n\
         ---------------------------- ENDED Service --------------------------------\n", @"GET", token, absurl);
    }
    
    if (HTTPRequestMethodPOST == method) {
        NSString *paramStr = [HFConfig dictionaryToJson:params];
        absurl = [[ServiceFactory getCurrentBaseAPI] stringByAppendingString:url];
        HFLog(@"\n\
        ---------------------------- BEGIN Service --------------------------------\n\
        method: %@ \n\
        ticket: %@ \n\
        absurl: %@ \n\
        params: %@ \n\
        ---------------------------- ENDED Service --------------------------------\n", @"POST", token, absurl, paramStr);
    }
    
    
}

+ (NSURLSessionDataTask *)requestWithUrl:(NSString *)url
                                  params:(id)params
                                  method:(HTTPRequestMethod)method
                                 success:(successBlock)success
                                 failure:(failureBlock)failure {
    if (HTTPRequestMethodGET == method) {
        [self getWithUrl:url params:params success:success failure:failure];
    } else if (HTTPRequestMethodPOST == method) {
        [self postWithUrl:url params:params success:success failure:failure];
    }
    return nil;
}

+ (NSURLSessionDataTask *)getWithUrl:(NSString *)url
                              params:(id)params
                             success:(successBlock)success
                             failure:(failureBlock)failure {
    [self setupServiceManagerWithUrl:url params:params method:HTTPRequestMethodGET];
    return  [ServiceManager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessResponse:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailureError:error failure:failure];
        
    }];
    
}

+ (NSURLSessionDataTask *)postWithUrl:(NSString *)url
                               params:(id)params
                              success:(successBlock)success
                              failure:(failureBlock)failure {
    
    [self setupServiceManagerWithUrl:url params:params method:HTTPRequestMethodPOST];
    return [ServiceManager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailureError:error failure:failure];
    }];
    
}

+ (NSURLSessionDataTask *)uploadWithUrl:(NSString *)url
                                 params:(id)params
                                 images:(NSArray<UIImage *> *)images
                                success:(successBlock)success
                                failure:(failureBlock)failure {
    [self setupServiceManagerWithUrl:url params:params method:HTTPRequestMethodPOST];
    return [ServiceManager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images) {
            [self handleFormData:formData fileData:[HFConfig compressSourceImage:image]];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailureError:error failure:failure];
    }];
    
}

+ (NSURLSessionDataTask *)uploadWithUrl:(NSString *)url
                                 params:(id)params
                                  datas:(NSArray<NSData *> *)imageDatas
                               progress:(progressBlock)progress
                                success:(successBlock)success
                                failure:(failureBlock)failure {
    [self setupServiceManagerWithUrl:url params:params method:HTTPRequestMethodPOST];
    return [ServiceManager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 这里注意每次遍历name和fileName均要不一致才可
        for (NSData *imageData in imageDatas) {
            [self handleFormData:formData fileData:imageData];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailureError:error failure:failure];
    }];
}

+ (NSURLSessionDataTask *)uploadWithUrl:(NSString *)url
                                 params:(id)params
                                   data:(NSData *)fileData
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                               mimeType:(NSString *)mimeType
                                success:(successBlock)success
                                failure:(failureBlock)failure {
    [self setupServiceManagerWithUrl:url params:params method:HTTPRequestMethodPOST];
    
    return [ServiceManager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessResponse:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailureError:error failure:failure];
    }];
    
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithUrl:(NSString *)url
                             filePath:(NSString *)filePath
                             progress:(progressBlock)progress
                              success:(successBlock)success
                              failure:(failureBlock)failure {
    [self setupServiceManagerWithUrl:url params:nil method:HTTPRequestMethodPOST];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [ServiceManager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        // 下载进度
        BLOCK_SAFE(progress, downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:filePath ? filePath : @"Download"];
        // 打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // 创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        // 拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //        NSLog(@"downloadDir = %@",downloadDir);
        // 返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        BLOCK_SAFE(success, filePath.absoluteString);
    }];
    
    // 开始下载
    [downloadTask resume];
    
    return downloadTask;
}


#pragma mark - private method
/** 处理返回结果 */
+ (void)handleSuccessResponse:(id)responseObject success:(successBlock)success
                      failure:(failureBlock)failure  {
    [MBProgressHUD hideHUDForView:[HFConfig lastWindow] animated:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    //    HGJLog(@"handleSuccessResponse==%@", responseObject);
    NSString *responStr =  [responseObject jk_JSONString];;
    HFLog(@"\n\
    ---------------------------- 服务器响应数据--------------------------------\n\
    %@ \n---------------------------- ENDED Service --------------------------------\n",responStr);
    NSString * sucStr = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"success"]];
    if ([sucStr isEqualToString:@"1"]||[sucStr isEqualToString:@"true"]) {
        BLOCK_SAFE(success, responseObject);
        
    } else{
        NSString *errorMessage = [responseObject objectForKey:@"errorMessage"];
        NSString *errorCode = [NSString stringWithFormat:@"%@",responseObject[@"errorCode"]];
        
        if ([errorCode isEqualToString:@"5001"] || [errorCode isEqualToString:@"1002"]) {
            if ([HFUserManager sharedHFUserManager].isLogin) {
                [MBProgressHUD showMessage:@"登录过期，请重新登录"];
                [[HFUserManager sharedHFUserManager] removeUserInfo];
                [UIApplication sharedApplication].keyWindow.rootViewController = [HomeViewController new];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"updateLogindata" object:@{@"name":@"请登录", @"sex":@"1",@"islogin":@"1"}];
            } else {
                [MBProgressHUD showMessage:errorMessage];
            }
        }
        HFError *error = [HFError errorWithCode:errorCode errorMessage:errorMessage];
        BLOCK_SAFE(failure,error);
    }
}

/** 处理错误结果 */
+ (void)handleFailureError:(NSError *)error failure:(failureBlock)failure{
    [MBProgressHUD hideHUDForView:[HFConfig lastWindow] animated:YES];
    HFLog(@"ERROR: %@", error.userInfo.description);
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    
    if (NSURLErrorCancelled != error.code) {
        HFError *hferror = [HFError errorWithCode:@"网络连接失败，请查看控制台打印数据" errorMessage:@"网络连接失败"];
        [AlertTool showTopWithText:@"网络异常，请检查网络设置"];
        [ShowHUD hiddenHUDLoading];
        BLOCK_SAFE(failure,hferror);
    }
}


/** 处理上传表单数据 */
+ (void)handleFormData:(id<AFMultipartFormData>)formData fileData:(NSData *)fileData {
    // 随机数图片名
    NSString *name = [NSString stringWithFormat:@"hgj_image_%d_%d_%d", arc4random_uniform(100), arc4random_uniform(100), arc4random_uniform(100)];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", name];
    
    // 上传表单数据
    [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:kServiceMimeType];
}

@end
