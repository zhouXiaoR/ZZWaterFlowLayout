//
//  MPFlowWaterLayout.m
//  MPWaterFlowDemo
//
//  Created by 周晓瑞 on 2017/4/17.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import "MPFlowWaterLayout.h"

@interface MPFlowWaterLayout ()

/**
 可见UICollectionViewLayoutAttributes集合
 */
@property(nonatomic,strong)NSMutableArray
<UICollectionViewLayoutAttributes*> *attrsArray;

/**
 行高度对应集合
 */
@property(nonatomic,strong)NSMutableDictionary *dataDic;

@end

@implementation MPFlowWaterLayout

- (NSMutableDictionary *)dataDic{
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attrsArray{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (instancetype)init{
    if (self = [super init]) {
        self.flowEdgeInset = UIEdgeInsetsMake(50, 20, 50, 20);
        self.rowSpace = 10;
        self.columCount = 3;
        self.columSpace = 20;
    }
    return self;
}

- (void)initDic{
    for (int i = 0; i<self.columCount; i++) {
        [self.dataDic setObject:@(self.flowEdgeInset.top) forKey:[NSString stringWithFormat:@"%d",i]];
    }
}


- (void)prepareLayout{
    [super prepareLayout];
    
    
    //每次布局前都要重新计算一遍
    [self initDic];
    
    [self.attrsArray removeAllObjects];
    
    NSInteger cout = [self.collectionView numberOfItemsInSection:0];
    for (int i=0;i<cout; i++) {
        UICollectionViewLayoutAttributes * att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attrsArray addObject:att];
    }
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
     __block  NSString *minKey  = @"0";
    
    [self.dataDic enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber * obj, BOOL * _Nonnull stop) {
        
        CGFloat minValue = [[self.dataDic objectForKey:minKey]floatValue];
        if([obj floatValue] < minValue){
            minKey = key;
        }
    }];
    
    CGFloat minY = [[self.dataDic objectForKey:minKey] floatValue];
     CGFloat y =  minY + self.rowSpace;
     CGFloat w = (self.collectionView.bounds.size.width - self.flowEdgeInset.left-self.flowEdgeInset.right - (self.columCount-1)*self.columSpace)/self.columCount;
    
    CGFloat x = self.flowEdgeInset.left + minKey.intValue*(w+self.columSpace);
    CGFloat h = [self.delegate waterFlowLayout:self indexPath:indexPath width:w];
    attrs.frame = CGRectMake(x,y,w,h);

    CGFloat reu = y + h;
    
    [self.dataDic setObject:@(reu) forKey:minKey];
    
    return attrs;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}
- (CGSize)collectionViewContentSize{
    
    __block  NSString *maxKey  = @"0";
    
    [self.dataDic enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber * obj, BOOL * _Nonnull stop) {
        CGFloat maxValue = [[self.dataDic objectForKey:maxKey] floatValue];
        if([obj floatValue] > maxValue){
            maxKey = key;
        }
    }];
    
    CGFloat reh = [[self.dataDic objectForKey:maxKey] floatValue] + self.flowEdgeInset.bottom;
    
    return CGSizeMake(0, reh);
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
