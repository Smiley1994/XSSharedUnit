//
//  XSUITextField.m
//  XSSharedUnit
//
//  Created by Good_Morning_ on 2020/6/15.
//  Copyright © 2020 smiley. All rights reserved.
//

#import "XSUITextField.h"

@implementation XSUITextField

//未编辑状态下的起始位置
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 5, 0);
}
// 编辑状态下的起始位置
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 5, 0);
}
//placeholder起始位置
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 5, 0);
}

@end
