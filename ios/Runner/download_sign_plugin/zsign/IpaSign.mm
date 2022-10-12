//
//  IpaSign.m
//  TestZsignIos
//
//  Created by dev on 2020/7/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import "IpaSign.h"
#include "zsign.h"
@implementation IpaSign
+ (BOOL)startSignWithCmd:(NSString *)cmd{
    NSArray *cmdArr=[cmd componentsSeparatedByString:@" "];
    char **cmdChar = new char *[cmdArr.count];
    for(int i=0;i<cmdArr.count;i++){
        cmdChar[i] = (char*)[cmdArr[i] UTF8String];
    }
    return ipaSign(cmdArr.count,cmdChar)==0;
}
@end
