//
//  WYPopupBgView.h
//  WYExtension
//
//  Created by wangyang on 2020/8/10.
//  Copyright © 2020年 WYExtension. All rights reserved.
//

#import "WYPopupBgView.h"
//#import <UIView+YYAdd.h>

@interface WYPopupBgView () <UIGestureRecognizerDelegate>
@end
@implementation WYPopupBgView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    self.bgAlphaColor = [UIColor colorWithWhite:0 alpha:0.6];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.userInteractionEnabled = YES;
    _container = [[UIView alloc] initWithFrame:self.bounds];
    _container.backgroundColor = [UIColor whiteColor];
    [self addSubview:_container];
    self.tapStrategy = [[APLPopupTapHideStrategy alloc] initWithPopup:self];
    self.popupAnimation = [[APLPopupAnimationFade alloc] initWithPopup:self];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        return;
    }

    [UIView animateWithDuration:self.popupAnimation.animationDuration animations:^{
        self.backgroundColor = self.bgAlphaColor;
    }];

    [self.popupAnimation showAnimation];
}

- (void)hide {
    [self endEditing:YES];
    // 背景动画
    [UIView animateWithDuration:self.popupAnimation.animationDuration animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }];

    [self.popupAnimation hideAnimation];
    // 如果 backgroundColor 没有任何变化，会立即执行 completion，导致container动画还未结束就removeFromSuperview
    // 所以把removeFromSuperview相关的方法单独拎出来
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.popupAnimation.animationDuration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        if (self.didDismissBlock) {
            self.didDismissBlock(self);
        }
    });
}

#pragma mark - 手势处理
- (void)popupTapOnBg {

}

- (void)popupTapOnContainer {

}

- (void)setTapStrategy:(id<WYPopupTapStrategy>)tapStrategy {
    NSAssert(![tapStrategy isMemberOfClass:[APLPopupTapBaseStrategy class]], @"不允许直接使用APLPopupTapBaseStrategy");
    _tapStrategy = tapStrategy;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:_tapStrategy action:@selector(popupTapAction)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    return [self.tapStrategy gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return [self.tapStrategy pointInside:point withEvent:event];
}
@end
