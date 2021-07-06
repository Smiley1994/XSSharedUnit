//
//  XSDictionary.h
//  XSSharedUnit
//
//  Created by Good_Morning_ on 2021/6/22.
//  Copyright © 2021 Good_Morning_. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XSDictionary : NSObject

+ (instancetype)dictionary;


- (void)setValue:(id)value forkey:(NSString *)key;

- (id)valueForKey:(NSString *)key;


/**
1. 每个对象创建时，都默认生成一个hashCode ,也就是一个经过哈希算法生成的一串数字 。当利用key去取字典中的value时，若是使用遍历或者二分查找等方法，效率都相对较低 ，于是出现了根据每个key生成的hashCode将该键值对放到hashCode对应的数组中的指定位置，这样当用key去取值时，便不必遍历去获取，即可以根据hashCode直接取出。
2. hashCode数字过大，或许会经过取余生成一个较小的数字，假如是对999取余，那么得到的结果始终处于0-999之间。但是，这样做的弊端在于取余所得到的值，可能是相同的，这样可能导致完全不相干的键值对被新的键值对（取余后值key相等）所覆盖。于是出现了数组中套链表实现的数组。这样，key值取余得到值相等的键值对，都将保存在同一个链表数组中，当查找key对应的值时，首先获取到该链表数组，然后遍历该数组，取正确的key所对应的值即可。
*/

@end

