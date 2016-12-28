//
//  IndexCollectionViewCell.m
//  PictureBook
//
//  Created by roycms on 2016/12/26.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "IndexCollectionViewCell.h"

@interface IndexCollectionViewCell()

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation IndexCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setModel:(IndexModel *)model{

    _model =model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.IMAGE_SRC] placeholderImage:[UIImage imageNamed:@"null"]];
    
    self.titleLabel.text = model.TITLE;
}
- (void)setupUI {
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
        make.height.equalTo(self.imageView.mas_width);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.height.offset(30);
    }];
}

//懒加载
- (UIImageView *)imageView {
    if(_imageView ==nil){
        _imageView =[[UIImageView alloc]init];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if(_titleLabel==nil){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor darkGrayColor];
    }
    return _titleLabel;
}


@end
