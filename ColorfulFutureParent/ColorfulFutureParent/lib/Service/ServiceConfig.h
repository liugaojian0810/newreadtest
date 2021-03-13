//
//  ServiceConfig.h
//  Selene
//
//  Created by 李春展 on 2020/5/18.
//  Copyright © 2020 huifan. All rights reserved.

//

#ifndef ServiceConfig_h
#define ServiceConfig_h

#if !defined BUILD_FOR_DEVELOP && !defined BUILD_FOR_RELEASE

#define BUILD_FOR_DEVELOP
#define BUILD_FOR_RELEASE // 生产环境的优先级最高

#endif

#if (defined(DEBUG) || defined(ADHOC) || !defined BUILD_FOR_RELEASE)
#define DELog(format, ...)  NSLog((@"FUNC:%s\n" "LINE:%d\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DELog(format, ...)
#endif

/** 服务器类型 */
typedef NS_ENUM (NSUInteger, ServerType) {
    ServerTypeMain,   // 主服务器
    ServerTypeOther,  // 其他服务器
};

/** 网络请求类型 */
typedef NS_ENUM (NSUInteger, HTTPRequestMethod) {
    HTTPRequestMethodGET,         // GET请求
    HTTPRequestMethodPOST,        // POST请求
    HTTPRequestMethodPOSTUpload,  // POST上传数据请求
    HTTPRequestMethodGETDownload  // GET下载文件请求，不做返回值解析
};

#endif /* ServiceConfig_h */
