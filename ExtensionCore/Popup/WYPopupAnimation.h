//
//  WYPopupAnimation.h
//  WYExtension
//
//  Created by wy on 2020/9/1.
//  Copyright © 2020 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYPopupAnimation <NSObject>
// 默认是0.3秒
@property (nonatomic, assign) CGFloat animationDuration;

- (void)showAnimation;
- (void)hideAnimation;

@end

@class WYPopupBgView;

// 抽象类，不要使用，使用其子类
@interface APLPopupBaseAnimation : NSObject <WYPopupAnimation>
- (instancetype)initWithPopup:(WYPopupBgView *)popup;
- (void)showAnimation;
- (void)hideAnimation;
@end

// 从底部滑出
@interface APLPopupAnimationFlipFromBottom : APLPopupBaseAnimation

@end

// 渐显
@interface APLPopupAnimationFade : APLPopupBaseAnimation

@end

// 从右边滑出
@interface APLPopupAnimationFlipFromRight : APLPopupBaseAnimation

@end

// 从中心显示
@interface APLPopupAnimationCenterScale : APLPopupBaseAnimation

@end



NS_ASSUME_NONNULL_END
