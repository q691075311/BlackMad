//
//  ClassDetailCell.m
//  blackmad
//
//  Created by taobo on 17/6/7.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassDetailCell.h"

@implementation ClassDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *textStr = [NSString stringWithFormat:@"￥34.00"];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    // 赋值
    self.oldPrice.attributedText = attribtStr;
    self.classImage.layer.masksToBounds = YES;
    self.classImage.layer.cornerRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
