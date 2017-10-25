//
//  MPCollectionViewCell.m
//  MPScrollViewAutoLayout
//
//  Created by 周晓瑞 on 2017/4/17.
//  Copyright © 2017年 colleny. All rights reserved.
//

#import "MPCollectionViewCell.h"
#import "MPShopItem.h"

@implementation MPCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setItem:(MPShopItem *)item{
    _item = item;
    
    self.backgroundColor  = [UIColor redColor];
}

@end
