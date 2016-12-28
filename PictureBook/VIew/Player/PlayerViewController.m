//
//  PlayerViewController.m
//  PictureBook
//
//  Created by roycms on 2016/12/26.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerCollectionViewCell.h"

static NSString * const cellName = @"PlayerCollectionViewCell";
@interface PlayerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, strong) UIView *playBar;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UISlider *playSlider;

typedef NSUInteger playType;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}


- (void)setupUI {
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    
    UICollectionViewFlowLayout *collectionViewflowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    collectionViewflowLayout.itemSize = self.view.bounds.size;
    collectionViewflowLayout.minimumInteritemSpacing = 0;
    collectionViewflowLayout.minimumLineSpacing = 0;
    collectionViewflowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    
    [self.collectionView registerClass:[PlayerCollectionViewCell class] forCellWithReuseIdentifier:cellName];
    self.pageCount = 13;
    
    
    [self.view addSubview:self.playBar];
    
    [self.playBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.offset(80);
    }];
    
    [self.playBar addSubview:self.playButton];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playBar);
        make.right.equalTo(self.playBar).offset(-50);
    }];
    
    [self.playBar addSubview:self.playSlider];
    [self.playSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playBar);
        make.left.equalTo(self.playBar).offset(50);
        make.right.equalTo(self.playButton.mas_left).offset(-20);;
    }];
}
- (void)sliderChange:(UISlider *)sender {
    
     [[AudioPlayerManager shareManager].audioPlayer seekToTime:sender.value*60];
}
-(void)playButtonAction:(UIButton*)sender{
    
    [[AudioPlayerManager shareManager].audioPlayer  play:@"http://picture-book.oss-cn-shanghai.aliyuncs.com/index/%E5%BD%93%E6%88%91%E5%94%B1%E8%B5%B7%E8%BF%99%E9%A6%96%E6%AD%8C.mp3"];

   [self.playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(updatedAudioPlayerData) userInfo:nil repeats:YES];
}

-(void)updatedAudioPlayerData
{
    
    self.playSlider.maximumValue = [AudioPlayerManager shareManager].audioPlayer.duration/60;
    
    NSLog(@"时长：%f",[AudioPlayerManager shareManager].audioPlayer.duration);
    NSLog(@"进度：%f",[AudioPlayerManager shareManager].audioPlayer.progress/60);
    
    self.playSlider.value = [AudioPlayerManager shareManager].audioPlayer.progress/60;

}

#pragma mark - collection view data sorce
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayerCollectionViewCell *cell = (PlayerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    cell.imageIndex = indexPath.item;
    cell.imageSrc = [NSString stringWithFormat:@"%@%d.jpeg",@"http://picture-book.oss-cn-shanghai.aliyuncs.com/%E5%AE%89%E7%9A%84%E7%A7%8D%E5%AD%90/",(int)indexPath.item];
    return cell;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor blackColor];
    }
    return _collectionView;
}

-(UIView *)playBar{

    if (!_playBar) {
        _playBar = [[UIView alloc]init];
        _playBar.backgroundColor =[UIColor whiteColor];
        _playBar.alpha = 0.6;
    }
    return _playBar;
}

-(UIButton *)playButton{
    if (!_playButton) {
        _playButton = [[UIButton alloc]init];
        
        [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_playButton setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
    }
    return _playButton;
}

-(UISlider *)playSlider{
    if (!_playSlider) {
        _playSlider =[[UISlider alloc]init];
        _playSlider.minimumValue = 0.0;//下限
        _playSlider.value = 0.0;//开始默认值
//        _playSlider.minimumTrackTintColor = [UIColor hx_colorWithHexRGBAString:@"fddb43"];
//        [_playSlider setThumbImage:[UIImage imageNamed:@"hd_ditu_juli_icon"] forState:UIControlStateNormal];
        [_playSlider addTarget:self action:@selector(sliderChange:) forControlEvents:(UIControlEventValueChanged)];
    }
    
    return _playSlider;
}



@end
