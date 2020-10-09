//
//  WYPopupAnimation.m
//  WYExtension
//
//  Created by wy on 2020/9/1.
//  Copyright © 2020 汪洋. All rights reserved.
//

#import "WYPopupAnimation.h"
#import "WYPopupBgView.h"
#import "UIView+Layout.h"

@interface APLPopupBaseAnimation ()

@property (nonatomic, weak) WYPopupBgView *popup;

@end

@implementation APLPopupBaseAnimation
@synthesize animationDuration;

- (instancetype)initWithPopup:(WYPopupBgView *)popup
{
    self = [super init];
    if (self) {
        self.popup = popup;
        self.animationDuration = 0.3;
    }
    return self;
}

- (void)showAnimation {

}

- (void)hideAnimation {

}
@end

@implementation APLPopupAnimationFlipFromBottom

- (void)showAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.fromValue = @(self.popup.container.bounds.size.height);
    animation.toValue = @(0);
    animation.duration = self.animationDuration;
    animation.beginTime = 0;
    animation.removedOnCompletion = YES;
    [self.popup.container.layer addAnimation:animation forKey:@"FlipFromBottom"];
}

- (void)hideAnimation {
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.popup.container.top = MAINSCREEN_HEIGHT;
    }];
}

@end


@implementation APLPopupAnimationFade
- (void)showAnimation {
    self.popup.container.alpha = 0;
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.popup.container.alpha = 1;
    }];
}

- (void)hideAnimation {
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.popup.container.alpha = 0;
    }];
}
@end

@implementation APLPopupAnimationFlipFromRight
- (void)showAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = @(self.popup.container.width);
    animation.toValue = @(0);
    animation.duration = self.animationDuration;
    animation.beginTime = 0;
    animation.removedOnCompletion = YES;
    [self.popup.container.layer addAnimation:animation forKey:@"FlipFromBottom"];
}

- (void)hideAnimation {
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.popup.container.left = MAINSCREEN_WIDTH;
    }];
}
@end

@implementation APLPopupAnimationCenterScale
- (void)showAnimation {
    self.popup.container.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        // 放大
        self.popup.container.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (void)hideAnimation {
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.popup.container.alpha = 0;
    }];
}
@end

