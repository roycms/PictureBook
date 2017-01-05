//
//  InitDataBase.h
//  PictureBook
//
//  Created by roycms on 2016/12/28.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface DataBaseManager : NSObject
+(void)initDataBase;
+(void)addData:(RLMObject *)rlmObject;
+(void)addDataWithArray:(NSArray *)rlmObjects modelClass:(Class)modelClass;
+(void)removeData:(RLMObject *)rlmObject;
@end
