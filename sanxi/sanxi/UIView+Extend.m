//
//  UIView+Extend.m
//  zhenlipain
//
//  Created by LingDarcy on 15/12/31.
//
//

#import "UIView+Extend.h"

@implementation UIView (Extend)


- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

