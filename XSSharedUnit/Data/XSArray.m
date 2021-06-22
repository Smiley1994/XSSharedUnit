//
//  XSArray.m
//  XSSharedUnit
//
//  Created by Good_Morning_ on 2021/6/22.
//  Copyright © 2021 Good_Morning_. All rights reserved.
//

#import "XSArray.h"

@interface XSArray ()

// frist node
@property (nonatomic, strong) Node *first;

// last node
@property (nonatomic, strong) Node *last;

@end

@implementation XSArray

- (void)addObject:(NSObject *)obj {
    
    if (!obj) return;
        _size ++ ;

        Node *node = [[Node alloc]init];
        //首个节点为空
        if (!_first) {
            _first = node;
            _last  = node;
            node.previous = nil;
            node.next     = nil;
            node.content  = obj;
            return;
        }

       //数组中有值
        node.previous = _last;
        node.next     = nil;
        node.content  = obj;
        _last         = node;
        _last.next    = node;
}

- (void)removeObject:(NSObject *)obj {
    if (!obj||!_size) return;

        Node *tmpNode = _first;

        for (NSInteger index = 0; index < _size; index ++) {

            if ([tmpNode.content isEqual:obj]) {

                [self removeNode:tmpNode]; //移除节点

                break;
            }
        }
}

- (void)removeObjectAtIndex:(NSInteger)index {
    
    if (index<0||index>=_size) return;

        Node *tmpNode = _first;

        for (NSInteger i = 0; i < _size; i ++) {

            if (i == index) {

                [self removeNode:tmpNode]; //移除节点

                break;
            }
            tmpNode   = tmpNode.next;
        }
}

- (NSObject *)objectAtIndex:(NSInteger)index {
    
    if (index<0||index>=_size) return nil;

        Node *tmpNode = _first;

        for (NSInteger i = 0; i < _size; i ++) {

            if (i == index) {

                return tmpNode.content;
            }
            tmpNode   = tmpNode.next;
        }
    
    return nil;
}


//私有
- (void)removeNode:(Node *)node
{
    //连接上下节点
    Node *preNode     = node.previous;
    Node *nextNode    = node.next;
    preNode.next      = nextNode;
    nextNode.previous = preNode;
    node.content      = nil; //清空被移除节点内容
    _size -- ;//长度更新
}

+ (instancetype)array {
    return [[self alloc] init];
}

@end





@implementation Node

@end
