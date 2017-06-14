//
//  ClassCell.m
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassCell.h"
#import "YYModel.h"


@interface ClassCell ()

@property (nonatomic,copy) NSArray * btnArr;
@property (nonatomic,strong) NSMutableArray * actArr;
@end

@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6;
    self.contentView.backgroundColor = COLORWITHRGB(239, 239, 239);
    self.actArr = [NSMutableArray array];
    self.btnArr = @[self.btn1,self.btn2,self.btn3];
    for (int i = 0; i<3; i++) {
        UIButton * btn = self.btnArr[i];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnCilck:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setActList:(ActList *)actList{
    self.typeName.text = actList.typeName;
    for (int i = 0; i<actList.productList.count; i++) {
        ActProductList * actPro = (ActProductList *) actList.productList[i];
        [self.actArr addObject:actPro];
        UIButton * btn = self.btnArr[i];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,actPro.promotionalPicturePath]] forState:UIControlStateNormal];
    }
}


- (void)btnCilck:(UIButton *)btn{
    NSInteger tag = btn.tag;
    ActProductList * actPro = self.actArr[tag];
    if (_delegate && [_delegate respondsToSelector:@selector(cilckCellBtnWithActProductList:)]) {
        [_delegate cilckCellBtnWithActProductList:actPro];
    }
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
