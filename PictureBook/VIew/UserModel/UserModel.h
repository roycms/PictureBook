//
//  UserModel.h
//  PictureBook
//
//  Created by roycms on 2017/1/3.
//  Copyright © 2017年 杜耀辉. All rights reserved.
//

#import <Realm/Realm.h>

@interface UserModel : RLMObject
@property int id; //编号
@property NSString *phone; //手机号
@property NSString *userName; //用户名
@property NSString *IMAGE_SRC; //用户头像
@property int BABY_AGE; //宝宝年龄
@end
