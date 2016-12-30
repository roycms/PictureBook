//
//  PlaylistView.m
//  PictureBook
//
//  Created by roycms on 2016/12/30.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "PlaylistView.h"
#import "IndexModel.h"
@interface PlaylistView() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic)UITableView *tableview;

@end
@implementation PlaylistView

-(instancetype)init{
    if (self = [super init]) {
    
        [self setupUI];

    }
    return self;
}

-(void)setDataList:(RLMResults *)dataList{
    _dataList = dataList;
    [self.tableview reloadData];
}

- (void)setupUI{
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(exit)];
    [self addGestureRecognizer:tapGesture];
    
    
    [self addSubview:self.tableview];
    self.tableview.backgroundColor = RGB16(0XFFFFFF);
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.offset(200);
    }];
    
    UILabel *headerView=[[UILabel alloc]init];
    headerView.text = @"播放列表";
    
    [self.tableview.tableHeaderView addSubview:headerView];

}

-(void)exit{
    [self removeFromSuperview];
}

#pragma table delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    cell.textLabel.text = ((IndexModel *)self.dataList[indexPath.row]).TITLE;
    
    if (cell.isSelected) {
        cell.textLabel.textColor = [UIColor yellowColor];
    }
    else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview =[[UITableView alloc]init];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    
    return _tableview;
}

@end
