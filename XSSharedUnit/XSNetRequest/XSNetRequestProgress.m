//
//  XSNetRequestProgress.m
//  TestProject
//
//  Created by 晓松 on 2019/4/28.
//  Copyright © 2019 ANN9. All rights reserved.
//

#import "XSNetRequestProgress.h"

@implementation XSNetRequestProgress

+ (instancetype)progressWithProgress:(NSProgress *)progress {
    return [[XSNetRequestProgress alloc]initWithProgress:progress];
}

- (instancetype)initWithProgress:(NSProgress *)progress {
    self = [super init];
    if(self){
        self.progress = progress;
        self.percent = progress.fractionCompleted;
    }
    return self;
}

@end
