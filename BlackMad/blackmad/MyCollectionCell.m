//
//  MyCollectionCell.m
//  blackmad
//
//  Created by taobo on 17/6/1.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionCancleBtn.layer.borderWidth = 1;
    self.collectionCancleBtn.layer.borderColor = [Tool appRedColor].CGColor;
    self.collectionCancleBtn.layer.masksToBounds = YES;
    self.collectionCancleBtn.layer.cornerRadius = 25/2;
    [self.collectionCancleBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
