//
//  XSNetRequestError.m
//  TestProject
//
//  Created by 晓松 on 2019/4/28.
//  Copyright © 2019 ANN9. All rights reserved.
//

#import "XSNetRequestError.h"

@implementation XSNetRequestError

- (instancetype)init {
    self =[super init];
    if(self){
        self.code = -1;
        self.message = @"未知错误";
    }
    return self;
}

- (instancetype)initWithMessage:(NSString *)message {
    self =[super init];
    if(self){
        self.code = -1;
        self.message = message;
    }
    return self;
}

- (instancetype)initWithCode:(NSInteger)code WithMessage:(NSString *)message{
    self =[super init];
    if(self){
        self.code = code;
        self.message = message;
    }
    return self;
}

@end
