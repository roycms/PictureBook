//
//  InitDataBase.m
//  PictureBook
//
//  Created by roycms on 2016/12/28.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager
+(void)initDataBase{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"dudu"] URLByAppendingPathExtension:@"realm"];
    // 2. 初始化
    [RLMRealmConfiguration setDefaultConfiguration:config];
}

+(void)addData:(RLMObject *)rlmObject{
    @try {
        RLMRealm *realm=[RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:rlmObject];
        [realm commitWriteTransaction];
    } @catch (NSException *exception) {
        NSLog(@"$$$$$$$$ addData:%@", exception);
    } @finally {
    }
}

+(void)addDataWithArray:(NSArray *)rlmObjects modelClass:(Class)modelClass{
    
    @try {
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm transactionWithBlock:^{
            for (NSDictionary * realMDic in rlmObjects) {
                [modelClass createOrUpdateInDefaultRealmWithValue:realMDic];
            }
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    } @finally {
        
    }
}

+(void)removeData:(RLMObject *)rlmObject{
    @try {
        if (rlmObject.isInvalidated || rlmObject == nil) {
            return;
        }
        if(rlmObject){
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm deleteObject:rlmObject];
            [realm commitWriteTransaction];
        }
        
    } @catch (NSException *exception) {
        NSLog(@"$$$$$$$$ removeData");
    } @finally {
        
    }
}
@end
