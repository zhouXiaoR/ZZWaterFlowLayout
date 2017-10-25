//
//  ViewController.m
//  MPWaterFlowDemo
//
//  Created by 周晓瑞 on 2017/4/17.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import "ViewController.h"
#import <UIView+MJExtension.h>
#import "MPCollectionViewCell.h"
#import "MPFlowWaterLayout.h"
#import <MJExtension.h>
#import "MPShopItem.h"

static NSString * const cellID = @"cell";

@interface ViewController ()
<UICollectionViewDelegate,UICollectionViewDataSource,MPFlowWaterLayoutDelegate>

@property(nonatomic,strong)NSMutableArray *imgsArray;

@end

@implementation ViewController

- (NSMutableArray*)imgsArray{
    if (_imgsArray == nil) {
     _imgsArray = [MPShopItem mj_objectArrayWithFilename:@"xmsh.plist"];
    }
    return _imgsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    MPFlowWaterLayout * lineLayout = [[MPFlowWaterLayout alloc]init];
    lineLayout.delegate = self;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,self.view.mj_w,self.view.mj_h) collectionViewLayout:lineLayout];
    collectionView.center = self.view.center;
    collectionView.delegate = self;
    collectionView.dataSource =self;
    collectionView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MPCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSoure

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MPCollectionViewCell  * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    MPShopItem * item = self.imgsArray[indexPath.row];
    cell.item = item;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgsArray.count;
}

- (CGFloat)waterFlowLayout:(MPFlowWaterLayout *)layout indexPath:(NSIndexPath *)indexPath width:(CGFloat)width{
    MPShopItem * item = self.imgsArray[indexPath.row];
    CGFloat metra = 1.0*width * item.shopHeight / item.shopWidth;
    return metra;
}


@end
