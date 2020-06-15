//
//  XSNetRequestManager.h
//  TestProject
//
//  Created by 晓松 on 2019/4/25.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSNetRequest.h"
#import "XSNetRequestError.h"
#import "XSNetRequestProgress.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XSNetRequestDelegate <NSObject>

@required
- (void)onRequestSucceed:(NSDictionary *)response ofWhat:(NSInteger)what;
- (void)onRequestFailed:(XSNetRequestError *)error ofWhat:(NSInteger)what;

@optional
- (void)onRequestStar:(XSNetRequest *)request;
- (void)onRequestFinished:(XSNetRequest *)request;
- (void)onProgress:(XSNetRequestProgress *)progress ofWhat:(NSInteger)what;


@end

@interface XSNetRequestManager : NSObject

- (void)addRequest:(XSNetRequest *)request withDelegate:(id<XSNetRequestDelegate>)delegate;

- (NSArray<XSNetRequest *> *)getAlarmRequest;

@end

NS_ASSUME_NONNULL_END
