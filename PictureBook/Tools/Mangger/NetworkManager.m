//
//  NetworkManager.m
//  igroup
//
//  Created by 张衡 on 2016/12/13.
//  Copyright © 2016年 北京三芳科技有限公司. All rights reserved.
//

#import "NetworkManager.h"

static NSString * const urlString = @"http://server.19860911.cn/";
@interface NetworkManager ()

@property (nonatomic, strong) NSMutableDictionary *requests;
@end

@implementation NetworkManager


- (void)requestType:(RequestType)type URLString:(NSString *)string params:(NSDictionary *)params completion:(callBack)completion {
    
    void(^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            completion(responseObject, nil);
        }
    };
    void(^failBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    };
    
    if (type == RequestTypeGet) {
        [self GET:string parameters:params progress:nil success:successBlock failure:failBlock];
    }
    if (type == RequestTypePost) {
        [self POST:string parameters:params progress:nil success:successBlock failure:failBlock];
    }
}

- (void)requestType:(RequestType)type URLString:(NSString *)string params:(NSDictionary *)params completion:(callBack)completion holdFirst:(BOOL)holdFirst {
    
    void(^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id responseObject) {
        [self.requests removeObjectForKey:string];
        if (responseObject) {
            completion(responseObject, nil);
        }
    };
    void(^failBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        [self.requests removeObjectForKey:string];
        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]) {
            return;
        }
        completion(nil, error);
    };
    
    NSURLSessionDataTask *originalTask = [self.requests objectForKey:string];
    if (holdFirst && originalTask) {
        return;
    }
    
    [originalTask cancel];
    NSURLSessionDataTask *task = nil;
    if (type == RequestTypeGet) {
        task = [self GET:string parameters:params progress:nil success:successBlock failure:failBlock];
    }
    if (type == RequestTypePost) {
        task = [self POST:string parameters:params progress:nil success:successBlock failure:failBlock];
    }
    [self.requests setValue:task forKey:string];
}

+ (instancetype)shareManager {
    NetworkManager *manager;
    NSURL *url = [NSURL URLWithString:urlString];
    manager = [[self alloc] initWithBaseURL:url];
    [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    return manager;
}

- (NSMutableDictionary *)requests {
    if (_requests == nil) {
        _requests = [NSMutableDictionary dictionary];
    }
    return _requests;
}

@end
