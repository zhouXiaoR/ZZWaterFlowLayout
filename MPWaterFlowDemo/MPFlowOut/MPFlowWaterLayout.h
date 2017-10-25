//
//  MPFlowWaterLayout.h
//  MPWaterFlowDemo
//
//  Created by 周晓瑞 on 2017/4/17.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPFlowWaterLayout;

@protocol MPFlowWaterLayoutDelegate <NSObject>

@required
- (CGFloat)waterFlowLayout:(MPFlowWaterLayout *)layout indexPath:(NSIndexPath*)indexPath width:(CGFloat )width;

@end


@interface MPFlowWaterLayout : UICollectionViewLayout

@property(nonatomic,assign)CGFloat columSpace;
@property(nonatomic,assign)CGFloat rowSpace;
@property(nonatomic,assign)UIEdgeInsets flowEdgeInset;
@property(nonatomic,assign) NSInteger columCount;

@property(nonatomic,weak)id <MPFlowWaterLayoutDelegate> delegate;

@end
