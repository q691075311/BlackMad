//
//  MainItemView.h
//  blackmad
//
//  Created by taobo on 17/6/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainItemDelegate <NSObject>

- (void)chooseBtnTag:(NSInteger)tag;

@end

@interface MainItemView : UIView

@property (nonatomic,assign) id<MainItemDelegate>delegate;
- (instancetype)initWithData:(NSArray *)arr;

@end
