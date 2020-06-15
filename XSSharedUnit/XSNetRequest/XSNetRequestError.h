//
//  XSNetRequestError.h
//  TestProject
//
//  Created by 晓松 on 2019/4/28.
//  Copyright © 2019 ANN9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSNetRequestErrorCode.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSNetRequestError : NSObject

@property (nonatomic,assign) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,weak) id attach;

- (instancetype)initWithMessage:(NSString *)message;
- (instancetype)initWithCode:(NSInteger)code WithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
