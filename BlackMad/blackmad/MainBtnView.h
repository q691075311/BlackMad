//
//  MainBtnView.h
//  blackmad
//
//  Created by taobo on 17/3/9.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainBtnViewDelegate <NSObject>

- (void)touchBtnWithBtn:(UIButton *)btn WithProductID:(NSNumber *)productID;

@end

@interface MainBtnView : UIView
@property (nonatomic,assign) id<MainBtnViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame WithProductID:(NSArray *)productID WithProductImage:(NSArray *)productImageArr WithProductTitleArr:(NSArray *)productTitleArr;

@end
