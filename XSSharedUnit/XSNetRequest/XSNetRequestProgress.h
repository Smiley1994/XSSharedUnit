//
//  XSNetRequestProgress.h
//  TestProject
//
//  Created by 晓松 on 2019/4/28.
//  Copyright © 2019 ANN9. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSNetRequestProgress : NSObject

@property (nonatomic,assign) double percent;
@property (nonatomic,strong) NSProgress*progress;
@property (nonatomic,weak) id attach;

+ (instancetype)progressWithProgress:(NSProgress *)progress;
- (instancetype)initWithProgress:(NSProgress *)progress;

@end

NS_ASSUME_NONNULL_END
