//
//  UIViewController+XSNetRequestManager.h
//  TestProject
//
//  Created by 晓松 on 2019/4/28.
//  Copyright © 2019 ANN9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSNetRequestManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XSNetRequestManager)<XSNetRequestDelegate>

- (void) setRequestManager:(XSNetRequestManager *)manager;
- (void) addRequest:(XSNetRequest *)request;

@end

NS_ASSUME_NONNULL_END
