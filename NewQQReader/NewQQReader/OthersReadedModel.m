//
//  OthersReadedModel.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "OthersReadedModel.h"

@implementation OthersReadedModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self.bid = dict[@"bid"];
    self.title = dict[@"title"];
    return self;
}
@end
