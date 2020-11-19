//
//  XSNetRequestManager.m
//  TestProject
//
//  Created by 晓松 on 2019/4/25.
//  Copyright © 2019 ann9. All rights reserved.
//

#import "XSNetRequestManager.h"
#import <AFNetworking/AFNetworking.h>

#pragma mark - String function
#define XSNBUNDLE [NSBundle bundleWithIdentifier:@"com.ann9.TestProject"]
#define LOCALIZE(arg) [XSNBUNDLE localizedStringForKey:(arg) value:@"" table:nil]
#define LOCALIZE_FORMAT(format,arg,...) [NSString stringWithFormat:LOCALIZE(format),arg]

static NSTimeInterval const XSNetRequestTimeoutInterval = 30;

@interface XSNetRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *tasks;
@property (nonatomic, strong) NSMutableArray *requests;

@property (nonatomic, copy) void (^requestSucceed) (id<XSNetRequestDelegate> delegate, NSInteger what, NSString *url, XSNetRequest *request, id responseObject, id attach);

@property (nonatomic, copy) void (^requestFailed) (id<XSNetRequestDelegate> delegate, NSInteger what, NSString *url, XSNetRequest *request, NSError *error, id attach);

@property (nonatomic, copy) void (^requestProgress) (id<XSNetRequestDelegate> delegate, NSInteger what, NSString *url, XSNetRequest *request, NSProgress *progress, id attach);

@end


@implementation XSNetRequestManager

- (instancetype)init {
    if (self == [super init]) {
        self.tasks = [[NSMutableDictionary alloc] init];
        self.requests = [[NSMutableArray alloc] init];
        self.manager = [AFHTTPSessionManager manager];
        
        __weak typeof(self) weakSelf = self;
        
        self.requestSucceed = ^(id<XSNetRequestDelegate> delegate, NSInteger what, NSString *url, XSNetRequest *request, id responseObject, id attach) {
            [weakSelf.tasks removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)what]];
            [weakSelf.requests removeObject:request];
            
            if (delegate && [delegate respondsToSelector:@selector(onRequestFinished:)]) {
                [delegate onRequestFinished:request];
            }
            
            [weakSelf requestSucceedOfDelegate:delegate ofWhat:what withResponse:responseObject andAttach:attach];
        };
        
        self.requestFailed = ^(id<XSNetRequestDelegate> delegate, NSInteger what, NSString *url, XSNetRequest *request, NSError *error, id attach) {
            [weakSelf.tasks removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)what]];
            
            [weakSelf.requests removeObject:request];
            
            if (delegate && [delegate respondsToSelector:@selector(onRequestFinished:)]) {
                [delegate onRequestFinished:request];
            }
            
            [weakSelf requestFailedOfDelegate:delegate ofWhat:what withError:error andAttach:(id)attach];
        };
        
        self.requestProgress = ^(id<XSNetRequestDelegate> delegate, NSInteger what, NSString *url, XSNetRequest *request, NSProgress *progress, id attach) {
            [weakSelf requestProgressOfDelegate:delegate ofWhat:what withProgress:progress andAttach:attach];
        };
        
        
    }
    return self;
}

- (void)requestSucceedOfDelegate:(id <XSNetRequestDelegate>) delegate ofWhat:(NSInteger)what withResponse:(id) responseObject andAttach:(id) attach {
    
    NSError *error = nil;
    
    responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
    
    __weak typeof(self) weakSelf = self;
    
    if (error && ![responseObject isKindOfClass:[NSDictionary class]]) {
        
        [weakSelf requestFailedOfDelegate:delegate ofWhat:what withErrorMessage:LOCALIZE_FORMAT(@"formatFailedToParseJson", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding], [error localizedDescription]) andAttach:(id)attach];
        return;
    }
    
    NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
    [responseDictionary setAttach:attach];
    if (delegate && [delegate respondsToSelector:@selector(onRequestSucceed:ofWhat:)]) {
        [delegate onRequestSucceed:responseDictionary ofWhat:what];
    }
    
    
}

- (void)requestFailedOfDelegate:(id<XSNetRequestDelegate>)delegate ofWhat:(NSInteger)what withError:(NSError *)error andAttach:(id) attach {
    if (delegate && [delegate respondsToSelector:@selector(onRequestFailed:ofWhat:)]) {
        
        XSNetRequestError *requestError = [[XSNetRequestError alloc] initWithCode:XS_ERROR_TIMEOUT WithMessage:[NSString stringWithFormat:@"请求失败，错误为“%@", [error localizedDescription]]];
        
        [requestError setAttach:attach];
        
        [delegate onRequestFailed:requestError ofWhat:what];
    }
}

- (void)requestFailedOfDelegate:(id <XSNetRequestDelegate>) delegate ofWhat:(NSInteger)what withErrorMessage:(NSString *)errorMessage andAttach:(id)attach {
   
    if (delegate && [delegate respondsToSelector:@selector(onRequestFailed:ofWhat:)]) {
        XSNetRequestError *error = [[XSNetRequestError alloc] initWithCode:-1 WithMessage:errorMessage];
        
        [error setAttach:attach];
        [delegate onRequestFailed:error ofWhat:what];
    }
}

- (void)requestProgressOfDelegate:(id<XSNetRequestDelegate>)delegate ofWhat:(NSInteger)what withProgress:(NSProgress *)progress andAttach:(id) attach {
    if (delegate && [delegate respondsToSelector:@selector(onProgress:ofWhat:)]) {
        XSNetRequestProgress *requestProgress = [XSNetRequestProgress progressWithProgress:progress];
        [requestProgress setAttach:attach];
        [delegate onProgress:requestProgress ofWhat:what];
        
    }
}

- (void)addRequest:(XSNetRequest *)request withDelegate:(id<XSNetRequestDelegate>)delegate {
    
    NSString *url = [request getUrl];
    
    id attach = [request getAttach];
    
    NSString *method = [request getMethod];
    
    NSDictionary *parameters = [request getParameters];
    
    NSDictionary *headers = [request getHeaders];
    
    NSInteger what = [request getWhat];
    
    BOOL isAjax = [request isAjax];
    
    self.manager.requestSerializer = [self requestSerializerWithUserAgent:request.userAgent];
    self.manager.responseSerializer = [self responseSerializer];
    
    if (isAjax) {
        [self.manager.requestSerializer setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    }
    
    NSURLSessionTask *task;
    
    if ([method isEqualToString:REQUEST_METHOD_GET]) {
        task = [self.manager GET:url parameters:parameters headers:headers progress:^(NSProgress * _Nonnull downloadProgress) {
            self.requestProgress(delegate, what, url, request, downloadProgress, attach);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.requestSucceed(delegate, what, url, request, responseObject, attach);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.requestFailed(delegate, what, url, request, error, attach);
        }];
    }
    
    else if ([method isEqualToString:REQUEST_METHOD_POST]) {
        task = [self.manager POST:url parameters:parameters headers:headers progress:^(NSProgress * _Nonnull uploadProgress) {
            self.requestProgress(delegate, what, url, request, uploadProgress, attach);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.requestSucceed(delegate, what, url, request, responseObject, attach);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.requestFailed(delegate, what, url, request, error, attach);
        }];
    }
    
    if (task) {
        [self.tasks setObject:task forKey:[NSString stringWithFormat:@"%ld",(long)what]];
    }
    
    [self.requests addObject:request];
    
    if (delegate && [delegate respondsToSelector:@selector(onRequestStar:)]) {
        [delegate onRequestStar:request];
    }
    
}

- (AFHTTPRequestSerializer *)requestSerializerWithUserAgent:(NSString *)userAgent {
    
    if (!userAgent) {
        userAgent = @"app/ios";
    }
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    serializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [serializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    serializer.timeoutInterval = XSNetRequestTimeoutInterval;
    
    return serializer;
}

- (AFHTTPRequestSerializer *)requestSerializer {
    return [self requestSerializerWithUserAgent:@"app/ios"];
}

- (AFHTTPResponseSerializer *)responseSerializer {
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    return serializer;
}

- (NSArray<XSNetRequest *> *)getAlarmRequest {
    NSMutableArray *alarmRequest = [[NSMutableArray alloc] init];
    [self.requests enumerateObjectsUsingBlock:^(XSNetRequest *  _Nonnull request, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (request.alarm) {
            [alarmRequest addObject:request];
        }
        
    }];
    return alarmRequest;
}

@end
