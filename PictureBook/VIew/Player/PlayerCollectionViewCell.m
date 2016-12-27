//
//  PlayerCollectionViewCell.m
//  PictureBook
//
//  Created by roycms on 2016/12/27.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//
#import <SDWebImage/UIImageView+WebCache.h>
#import "PlayerCollectionViewCell.h"

@interface PlayerCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation PlayerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.imageView];
    self.imageView.frame =  self.contentView.frame;
}


-(void)setImageSrc:(NSString *)imageSrc{
    
    _imageSrc = imageSrc;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageSrc] placeholderImage:[UIImage imageNamed:@"null"]];

}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}
@end
