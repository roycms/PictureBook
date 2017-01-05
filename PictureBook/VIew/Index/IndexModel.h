//
//  IndexModel.h
//  PictureBook
//
//  Created by roycms on 2016/12/26.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import <Realm/Realm.h>


//@interface IndexResourceModel : RLMObject
//@property NSString *id;
//@property NSString *imageSrc;
//@property long *starTime;
//@property long *endTime;
//@end
//RLM_ARRAY_TYPE(IndexResourceModel)

@interface IndexModel : RLMObject
@property int id; //编号
@property NSString *TITLE; // 绘本标题
@property NSString *IMAGE_SRC; //绘本封面地址
@property NSString *AUDIO_SRC; //绘本声音地址
//@property RLMArray<IndexResourceModel> *resources;
@end

