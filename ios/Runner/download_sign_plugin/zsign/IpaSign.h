//
//  IpaSign.h
//  TestZsignIos
//
//  Created by dev on 2020/7/23.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IpaSign : NSObject
+ (BOOL)startSignWithCmd:(NSString *)cmd;
@end
NS_ASSUME_NONNULL_END
