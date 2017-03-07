//
//  UIViewController+KeyboardCorver.m
//  KeyBoardTest
//
//  Created by CxDtreeg on 15/10/30.
//  Copyright © 2015年 CxDtreeg. All rights reserved.
//

#import "UIViewController+KeyboardCorver.h"

static void * keyboardHideTapGestureKey = (void *)@"keyboardHideTapGesture";//键盘点击隐藏手势
static void * objectViewKey = (void *)@"objectView";//目标视图

@implementation UIViewController (KeyboardCorver)

@dynamic keyboardHideTapGesture;
@dynamic objectView;

#pragma mark - 设置键盘隐藏单击手势 setter getter
- (void)setKeyboardHideTapGesture:(UITapGestureRecognizer *)keyboardHideTapGesture{
    objc_setAssociatedObject(self, keyboardHideTapGestureKey, keyboardHideTapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)keyboardHideTapGesture{
    return objc_getAssociatedObject(self, keyboardHideTapGestureKey);
}

#pragma mark - 设置获取目标对象 setter getter
- (void)setObjectView:(UIView *)objectView{
    objc_setAssociatedObject(self, objectViewKey, objectView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)objectView{
    return objc_getAssociatedObject(self, objectViewKey);
}

#pragma mark - 添加键盘通知
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setKeyboardHideTapGesture:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandel)]];
    [self.view addGestureRecognizer:self.keyboardHideTapGesture];
}

#pragma mark - 清理通知和移除手势
- (void)clearNotificationAndGesture{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view removeGestureRecognizer:self.keyboardHideTapGesture];
}

#pragma mark - 单击手势调用
- (void)tapGestureHandel{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - 查找第一响应者
- (void)findFirstResponse:(UIView *)view{
    UIView * ojView = self.objectView;
    ojView = nil;
    for (UIView * tempView in view.subviews) {
        if ([tempView isFirstResponder] &&
            ([tempView isKindOfClass:[UITextField class]] ||
             [tempView isKindOfClass:[UITextView class]])) {//要进行类型判断
                [self setObjectView:tempView];
            }
        if (tempView.subviews.count != 0) {
            [self findFirstResponse:tempView];
        }
    }
}

#pragma mark - 键盘通知接收处理
- (void)keyboardNotify:(NSNotification *)notification{

    NSValue * frameNum = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = frameNum.CGRectValue;
    CGFloat keyboardHeight = rect.size.height;//键盘高度
    
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];//获取键盘动画持续时间
    NSInteger curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];//获取动画曲线
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {//键盘显示
        [self findFirstResponse:self.view];
        UIView * tempView = self.objectView;
        CGRect rect = [tempView.superview convertRect:tempView.frame fromView:self.view];//计算响应者到和屏幕的绝对位置
        CGPoint point = rect.origin;

        CGFloat offset = (fabs(point.y) +tempView.frame.size.height+20) - (self.view.frame.size.height - keyboardHeight);
        
        // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
        double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        //将视图上移计算好的偏移
        if(offset > 0) {
            [UIView animateWithDuration:duration animations:^{
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"KeyboardShow" object:@"keyboardHeight" userInfo:@{@"keyboardHeight":@(keyboardHeight)}];

    }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]){//键盘隐藏

        [[NSNotificationCenter defaultCenter]postNotificationName:@"Keyboardhidden" object:nil];

        if (duration > 0) {
            [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                self.view.transform = CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                self.view.frame = CGRectMake(0.0f, 0, self.view.frame.size.width, self.view.frame.size.height);
            }];
        }else{
            self.view.transform = CGAffineTransformIdentity;
        }
    }
}

@end
