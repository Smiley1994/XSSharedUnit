//
//  XSNetRequest.m
//  TestProject
//
//  Created by 晓松 on 2019/4/25.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSNetRequest.h"
#import <UIKit/UIKit.h>

static void * KEY_REQUEST_ATTACH_OF_OBJC_RUNTIME = &KEY_REQUEST_ATTACH_OF_OBJC_RUNTIME;

NSString *const KEY_REQUEST_ATTACH = @"KEY_REQUEST_ATTACH";
NSString *const REQUEST_METHOD_GET = @"GET";
NSString *const REQUEST_METHOD_POST = @"POST";


@implementation NSDictionary(XSAttach)

- (void)setAttach:(id)attach {
    objc_setAssociatedObject(self, KEY_REQUEST_ATTACH_OF_OBJC_RUNTIME, attach, OBJC_ASSOCIATION_ASSIGN);
}

- (id)getAttach {
    return  objc_getAssociatedObject(self, KEY_REQUEST_ATTACH_OF_OBJC_RUNTIME);
}

@end

@interface XSNetRequest ()

@property (nonatomic,weak) id attach;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,assign) NSInteger what;
@property (nonatomic,strong) NSString *method;
@property (nonatomic,assign) BOOL isAjax;
@property (nonatomic,strong) NSMutableDictionary *paramters;

@end

@implementation XSNetRequest

+ (instancetype)requestWithUrl:(NSString *)url andWhat:(NSInteger)what {
    return [[XSNetRequest alloc] initWithUrl:url andWhat:what];
}

+ (instancetype)requestWithUrl:(NSString *)url andWhat:(NSInteger)what andMethod:(NSString *)method {
    return [[XSNetRequest alloc] initWithUrl:url andWhat:what andMethod:method];
}

- (void)setAttach:(id)attach {
    _attach = attach;
}
- (id)getAttach {
    return _attach;
}

// 默认 GET 请求
- (instancetype)initWithUrl:(NSString *)url andWhat:(NSInteger)what {
    return [self initWithUrl:url andWhat:what andMethod:REQUEST_METHOD_GET];
}

- (instancetype)initWithUrl:(NSString *)url andWhat:(NSInteger)what andMethod:(NSString *)method {
    if (self == [super init]) {
        self.url = url;
        self.what = what;
        self.method = method;
        self.paramters = [[NSMutableDictionary alloc] init];
        self.userAgent = @"app/ios";
    }
    return self;
}

- (void)setAjax:(BOOL)isAjax {
    _isAjax = isAjax;
}

- (BOOL)isAjax {
    return _isAjax;
}

- (NSString *)getUrl {
    return _url;
}

- (NSString *)url {
    return _url;
}

- (NSInteger)getWhat {
    return _what;
}

- (NSInteger)what {
    return _what;
}

- (NSString *)getMethod {
    return _method;
}

- (NSString *)method {
    return _method;
}


- (void)setParameters:(NSDictionary *)parameters {
    _paramters = [NSMutableDictionary dictionaryWithDictionary:parameters];
}

- (NSDictionary *)getParameters {
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    [self.paramters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[UIImage class]]) {
            [temp setObject:obj forKey:key];
        }
    }];
    return temp;
}

- (NSDictionary *)parameters {
    return [self getParameters];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [self.paramters setObject:value forKey:key];
}

@end
