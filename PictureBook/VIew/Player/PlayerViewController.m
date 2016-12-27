//
//  PlayerViewController.m
//  PictureBook
//
//  Created by roycms on 2016/12/26.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()
@property (nonatomic) STKAudioPlayer *audioPlayer;

typedef NSUInteger playType;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.audioPlayer play:@"http://picture-book.oss-cn-shanghai.aliyuncs.com/index/%E5%BD%93%E6%88%91%E5%94%B1%E8%B5%B7%E8%BF%99%E9%A6%96%E6%AD%8C.mp3"];
     [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(updatedAudioPlayerData) userInfo:nil repeats:YES];
    

}

-(void)updatedAudioPlayerData
{
    NSLog(@"时长：%f",self.audioPlayer.duration);
    NSLog(@"进度：%f",self.audioPlayer.progress/60);
}

-(STKAudioPlayer *)audioPlayer{
    
    if (!_audioPlayer) {
        _audioPlayer = [[STKAudioPlayer alloc] init];
        _audioPlayer.delegate =self;
    }
    return _audioPlayer;
}


/// Raised when an item has started playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId {
    
    //跳到 120秒后播放
    [self.audioPlayer seekToTime:120];
}

/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId {
}

/// Raised when the state of the player has changed
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState {
}

/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration {
}

/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode {
}


@end
