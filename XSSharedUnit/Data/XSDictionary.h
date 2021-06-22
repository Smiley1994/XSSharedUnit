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

@end

