//
//  DataUtils.m
//  XSSharedUnit
//
//  Created by Good_Morning_ on 2021/1/5.
//  Copyright © 2021 Good_Morning_. All rights reserved.
//

#import "DataUtils.h"

@implementation DataUtils

+ (NSString *)readTxtFileContent:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];           
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return  content;
}

@end
