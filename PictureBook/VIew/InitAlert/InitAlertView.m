//
//  InitAlertView.m
//  PictureBook
//
//  Created by roycms on 2016/12/30.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "InitAlertView.h"

@interface InitAlertView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIPickerView * pickerView;

@end
@implementation InitAlertView
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)contentViewUI{
    [self.contentView addSubview:self.pickerView];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-35);
        make.height.offset(130);
    }];
}

-(void)setPickerDataSource:(NSArray *)pickerDataSource{

    _pickerDataSource = pickerDataSource;
    [self contentViewUI];

}

#pragma mark UIPickerView DataSource Method 数据源方法

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerDataSource.count;
}

#pragma mark UIPickerView Delegate Method 代理方法

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickerDataSource[row];
}


-(UIPickerView *)pickerView {

    if (!_pickerView) {
        _pickerView =[[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    
    return _pickerView;
}

@end
