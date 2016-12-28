//
//  IndexNetwork.m
//  PictureBook
//
//  Created by roycms on 2016/12/28.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "IndexNetwork.h"
#import "IndexModel.h"
@implementation IndexNetwork

- (void)loadBook:(callBack)callBack {
    
    void(^block)(NSDictionary *data, NSError * error) = ^(NSDictionary *data, NSError * error) {
        //存库 操作
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            for (NSDictionary * realMDic in data[@"data"]) {
                [[IndexModel class] createOrUpdateInDefaultRealmWithValue:realMDic];
            }
        }];
        
        callBack(data,error);
    };

    [self requestType:RequestTypeGet URLString:@"dudu_book" params:nil completion:block];
}
@end
