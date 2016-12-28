//
//  ViewController.m
//  PictureBook
//
//  Created by roycms on 2016/12/20.
//  Copyright © 2016年 杜耀辉. All rights reserved.
//

#import "IndexViewController.h"

#import "SearchController.h"
#import "IndexCollectionViewCell.h"
#import "IndexNetwork.h"
#import "PlayerViewController.h"

@interface IndexViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) UIButton *ageButton; //年龄段分类
@property (nonatomic,strong) UIButton *featureButton; //特色分类

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@property RLMResults * dataList;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataList = [IndexModel allObjects];
    [self prepareUI];
    [self prepareData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.ageButton removeFromSuperview];
    [self.featureButton removeFromSuperview];
}

-(void)prepareData{
    [[IndexNetwork shareManager] loadBook:^(NSDictionary *data, NSError * error) {
        if (error) {
            return ;
        }
        [self.collectionView reloadData];
    }];
}

-(void)prepareUI{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜搜" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];

    [self.navigationController.navigationBar addSubview:self.ageButton];
    [self.navigationController.navigationBar addSubview:self.featureButton];
    self.ageButton.frame = CGRectMake(0, 0, 80, 40);
    self.featureButton.frame = CGRectMake(80, 0, 80, 40);
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(10,3, 0, 3));
        
    }];

}


-(void)leftAction:(UIBarButtonItem*)sender{

    self.definesPresentationContext = YES;
    
    SearchController *searchController =[[SearchController alloc]initWithSearchResultsController:self];

    searchController.searchBar.backgroundColor = [UIColor redColor];

    searchController.dimsBackgroundDuringPresentation = NO;//是否添加半透明覆盖层
    
    searchController.hidesNavigationBarDuringPresentation = YES;//是否隐藏导航栏

    [self.navigationController.view addSubview:searchController.searchBar];

}

#pragma mark - collection view data delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IndexCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IndexCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - collection view delegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerViewController *vc =[[PlayerViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

//懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource  =self;
        _collectionView.pagingEnabled = YES;
        _collectionView.alwaysBounceVertical =YES;
        _collectionView.alwaysBounceHorizontal =NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[IndexCollectionViewCell class] forCellWithReuseIdentifier:@"IndexCollectionViewCell"];
        
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    int size;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        size =([UIScreen mainScreen].bounds.size.width-6)/4;
    }
    else{
        size =([UIScreen mainScreen].bounds.size.width-6)/2;
    }
   
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.itemSize = CGSizeMake(size, size + 30);
    }
    return _flowLayout;
}

#pragma make 懒加载

-(UIButton *)ageButton{
    if (!_ageButton) {
        _ageButton =[[UIButton alloc]init];
        [_ageButton setTitle:@"年龄" forState:UIControlStateNormal];
        [_ageButton setTitleColor:RGB16(0x000000) forState:UIControlStateNormal];
    }
    
    return _ageButton;
}
-(UIButton *)featureButton{
    if (!_featureButton) {
        _featureButton =[[UIButton alloc]init];
        [_featureButton setTitle:@"功能" forState:UIControlStateNormal];
        [_featureButton setTitleColor:RGB16(0x000000) forState:UIControlStateNormal];
    }
    
    return _featureButton;
}

@end
