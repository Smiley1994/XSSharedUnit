//
//  UIViewController+XSNetRequestManager.m
//  TestProject
//
//  Created by 晓松 on 2019/4/28.
//  Copyright © 2019 ANN9. All rights reserved.
//

#import "UIViewController+XSNetRequestManager.h"

static void* XSN_KEY_VIEW_CONTROLLER_REQUEST_MANAGER = &XSN_KEY_VIEW_CONTROLLER_REQUEST_MANAGER;

@implementation UIViewController (XSNetRequestManager)

- (void)addRequest:(XSNetRequest *)request {
    [[self xsnRequestManager] addRequest:request withDelegate:self];
}

- (XSNetRequestManager *)xsnRequestManager {
    XSNetRequestManager *requestManager = objc_getAssociatedObject(self, XSN_KEY_VIEW_CONTROLLER_REQUEST_MANAGER);
    if (!requestManager) {
        requestManager = [[XSNetRequestManager alloc] init];
        [self setRequestManager:requestManager];
    }
    return requestManager;
}

- (void)setRequestManager:(XSNetRequestManager *)manager {
    objc_setAssociatedObject(self, XSN_KEY_VIEW_CONTROLLER_REQUEST_MANAGER, manager, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - ======= XSNetRequestDelegate =======

- (void)onRequestSucceed:(nonnull NSDictionary *)response ofWhat:(NSInteger)what {
    
}

- (void)onRequestFailed:(nonnull XSNetRequestError *)error ofWhat:(NSInteger)what { 
    
}

- (void)onProgress:(XSNetRequestProgress *)progress ofWhat:(NSInteger)what {
    
}

- (void)onRequestStar:(XSNetRequest *)request {
    
}

- (void)onRequestFinished:(XSNetRequest *)request {
    
}


@end
