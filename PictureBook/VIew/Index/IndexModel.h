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
@property int id;
@property NSString *TITLE;
@property NSString *IMAGE_SRC;
@property NSString *AUDIO_SRC;
//@property RLMArray<IndexResourceModel> *resources;
@end

