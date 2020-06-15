//
//  XSNetRequest.h
//  TestProject
//
//  Created by 晓松 on 2019/4/25.
//  Copyright © 2019 ann9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const KEY_REQUEST_ATTACH;
FOUNDATION_EXTERN NSString *const REQUEST_METHOD_GET;
FOUNDATION_EXTERN NSString *const REQUEST_METHOD_POST;

@interface NSDictionary (XSAttach)

- (void)setAttach:(id)attach;

- (id)getAttach;

@end

@interface XSNetRequest : NSObject

@property (nonatomic, assign) BOOL alarm;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *userAgent;


- (NSString *)getUrl;
- (NSInteger)getWhat;
- (NSString *)getMethod;

- (NSString *)url;
- (NSInteger)what;
- (NSString *)method;

- (void)setParameters:(NSDictionary *)parameters;
- (NSDictionary *)getParameters;
- (NSDictionary *)parameters;

- (instancetype)initWithUrl:(NSString *)url andWhat:(NSInteger)what;
- (instancetype)initWithUrl:(NSString *)url andWhat:(NSInteger)what andMethod:(NSString *)method;

- (void)setAjax:(BOOL)isAjax;
- (BOOL)isAjax;

- (void)setAttach:(id)attach;
- (id)getAttach;

+ (instancetype)requestWithUrl:(NSString *)url andWhat:(NSInteger)what;
+ (instancetype)requestWithUrl:(NSString *)url andWhat:(NSInteger)what andMethod:(NSString *)method;

@end




NS_ASSUME_NONNULL_END
