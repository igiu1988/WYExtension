//
//  WYPopupBgView.h
//  WYExtension
//
//  Created by wangyang on 2020/8/10.
//  Copyright © 2020年 WYExtension. All rights reserved.
//
#import "WYPopupTapStrategy.h"
#import "WYPopupAnimation.h"

/**
 所有使用半透明背景的popView，都使用该Class作为父类
 */
@interface WYPopupBgView : UIView

/// 点击背景时，该如何响应。默认是 APLPopupTapHideStrategy
@property (nonatomic, strong) id<WYPopupTapStrategy> tapStrategy;

/// container 动画对象。默认是 APLPopupAnimationFade
@property (nonatomic, strong) id<WYPopupAnimation> popupAnimation;

// 半透明背景颜色。默认是[UIColor colorWithWhite:0 alpha:0.6]
@property (nonatomic, strong) UIColor *bgAlphaColor;
@property (nonatomic, copy) void (^didDismissBlock) (WYPopupBgView *popup);

/**
 container的背景颜色，位置（坐标或者约束）是可以自定义的。
 container的大小可以使用约束自动计算，也可以显示的设置size.
 在 setup 方法中设置的 container 坐标是最终显示的坐标。
 */
@property (nonatomic, strong) UIView *container;

#pragma mark - 重写的入口
- (void)setup;

/**
 当tapStrategy为APLPopupTapHideStrategy时，点击半透明背景会触发该方法隐藏，执行隐藏动画，然后removeFromSuperview。
 注意：不会调用didDismissBlock
 */
- (void)hide;

// 当点击背景需要响应手势时，会调用该方法
- (void)popupTapOnBg;

// 当手势点击到 container，并且container中没有任何子视图接收该事件时，会调用方法：tapOnContainer，该方默认什么也不做。还未遇到过有什么需求需要重写该方法。也许可以利用它来收起键盘。
- (void)popupTapOnContainer;

@end
