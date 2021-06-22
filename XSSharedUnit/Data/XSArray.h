//
//  XSArray.h
//  XSSharedUnit
//
//  Created by Good_Morning_ on 2021/6/22.
//  Copyright © 2021 Good_Morning_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSArray : NSObject

// array length
@property (nonatomic, assign) NSUInteger size;

//添加元素
- (void)addObject:(NSObject *)obj;

//移除指定元素
- (void)removeObject:(NSObject *)obj;

//移除指定索引元素
- (void)removeObjectAtIndex:(NSInteger)index;

//获取指定位置的值
- (NSObject *)objectAtIndex:(NSInteger)index;

//数组初始化
+ (instancetype)array;

@end


#pragma - Node

@interface Node : NSObject

//上个节点
@property (nonatomic, strong) Node *previous;

//下个节点
@property (nonatomic, strong) Node *next;

//当前节点内容
@property (nonatomic, strong) id content;

@end

