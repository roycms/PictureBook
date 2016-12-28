//
//  NetworkManager.h
//  igroup
//
//  Created by 张衡 on 2016/12/13.
//  Copyright © 2016年 北京三芳科技有限公司. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypePost,
    RequestTypeGet,
    RequestTypePut,
};

typedef void(^callBack)(id, NSError *);

@interface NetworkManager : AFHTTPSessionManager

/**
 实例化

 @return 实例
 */
+ (instancetype)shareManager;

/**
 常规网络请求

 @param type       请求方式
 @param string     URL
 @param params     参数
 @param completion 回调
 */
- (void)requestType:(RequestType)type URLString:(NSString *)string params:(NSDictionary *)params completion:(callBack)completion;

/**
 可控网络请求

 @param type       请求方式
 @param string     URL
 @param params     参数
 @param completion 回调
 @param holdFirst  保留第一次请求
 */
- (void)requestType:(RequestType)type URLString:(NSString *)string params:(NSDictionary *)params completion:(callBack)completion holdFirst:(BOOL)holdFirst;

@end
