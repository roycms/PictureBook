//
//  InitDataBase.m
//  PictureBook
//
//  Created by roycms on 2016/12/28.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "InitDataBase.h"

@implementation InitDataBase
+(void)initDataBase{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"dudu"] URLByAppendingPathExtension:@"realm"];
    
    // 1. 清库
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray<NSURL *> *realmFileURLs = @[config.fileURL,
                                        [config.fileURL URLByAppendingPathExtension:@"lock"],
                                        [config.fileURL URLByAppendingPathExtension:@"log_a"],
                                        [config.fileURL URLByAppendingPathExtension:@"log_b"],
                                        [config.fileURL URLByAppendingPathExtension:@"note"],
                                        [config.fileURL URLByAppendingPathExtension:@"management"]];
    
    
    for (NSURL *URL in realmFileURLs) {
        NSError *error = nil;
        [manager removeItemAtURL:URL error:&error];
    }
    // 2. 初始化
    [RLMRealmConfiguration setDefaultConfiguration:config];
}
@end
