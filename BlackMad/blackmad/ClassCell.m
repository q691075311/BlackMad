//
//  ClassCell.m
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassCell.h"

@interface ClassCell ()

@end

@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6;
    self.contentView.backgroundColor = COLORWITHRGB(239, 239, 239);
    self.image1.image = [UIImage imageNamed:@"logo"];
    self.image2.image = [UIImage imageNamed:@"logo"];
    self.image3.image = [UIImage imageNamed:@"logo"];
}

- (IBAction)clickMore:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cilckMoreBtn:)]) {
        [self.delegate cilckMoreBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
