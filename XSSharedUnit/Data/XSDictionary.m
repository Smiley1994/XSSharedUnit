//
//  XSDictionary.m
//  XSSharedUnit
//
//  Created by Good_Morning_ on 2021/6/22.
//  Copyright © 2021 Good_Morning_. All rights reserved.
//

#import "XSDictionary.h"
#import "XSArray.h"

@interface KeyValueCache : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) id  value;

@end

@implementation KeyValueCache

+ (instancetype)key:(NSString *)key value:(id)value {
    
    KeyValueCache *model = [[self alloc]init];
    model.key   = key;
    model.value = value;

    return model;
}

@end


@interface XSDictionary ()

@end

@implementation XSDictionary {
    XSArray *_keyValues[999];
}

+ (instancetype)dictionary {
    return [[self alloc] init];
}

- (void)setValue:(id)value forkey:(NSString *)key {
    //获取hashCode
    NSUInteger hash        = key.hash;
    //默认一个对象占用8个字节
    NSUInteger realCode    = hash%(sizeof(_keyValues)/8);

    XSArray *linkArr = _keyValues[realCode];
    if (linkArr) { //如果存在链表数组

        for (NSInteger index = 0; index < linkArr.size; index ++) {

            KeyValueCache *keyValue = (KeyValueCache *)[linkArr objectAtIndex:index];
            if ([keyValue.key isEqualToString:key]) { //如果存在相同的Key ，更新value
                keyValue.value = value; //重新赋值value
                return;
            }
        }

        //创建新的键值对存储
        KeyValueCache *newKeyValue  = [KeyValueCache key:key value:value];
        [linkArr addObject:newKeyValue];

    }else{ //不存在链表数组

        //创建新的链表数组
        XSArray *newLinkArray = [XSArray array];
        KeyValueCache *newKeyValue  = [KeyValueCache key:key value:value];
        [newLinkArray addObject:newKeyValue];
        _keyValues[realCode]        = newLinkArray;
    }

}

- (id)valueForKey:(NSString *)key {
    if (!key.length) return nil;

        //获取hashCode
        NSUInteger hash        = key.hash;
        NSUInteger realCode    = hash%(sizeof(_keyValues)/8);

        XSArray *linkArr = _keyValues[realCode];
        if (linkArr) {

            //遍历链表，取出value
            for (NSInteger index = 0; index < linkArr.size; index ++) {

                KeyValueCache *keyvalue = (KeyValueCache *)[linkArr objectAtIndex:index];
                if ([keyvalue.key isEqualToString:key]) {

                    return keyvalue.value;
                }
            }
        }

        return nil;
}

@end
