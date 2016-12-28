//
//  AudioPlayerManager.h
//  PictureBook
//
//  Created by roycms on 2016/12/28.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STKAudioPlayer.h"

//typedef NS_ENUM(NSUInteger, PlayState) {
//    Play,
//    Pause,
//    Stop,
//};

@interface AudioPlayerManager : NSObject<STKAudioPlayerDelegate>
@property (nonatomic) STKAudioPlayer *audioPlayer;
@property NSUInteger playState;
+ (instancetype)shareManager;
@end
