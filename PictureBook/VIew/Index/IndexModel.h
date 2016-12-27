//
//  IndexModel.h
//  PictureBook
//
//  Created by roycms on 2016/12/26.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import <Realm/Realm.h>


@interface IndexResourceModel : RLMObject
@property NSString *id;
@property NSString *imageSrc;
@property long *starTime;
@property long *endTime;
@end
RLM_ARRAY_TYPE(IndexResourceModel)

@interface IndexModel : RLMObject
@property NSString *id;
@property NSString *title;
@property NSString *imageSrc;
@property NSString *audioSrc;
@property NSString *videoSrc;
@property RLMArray<IndexResourceModel> *resources;
@end

