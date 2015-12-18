//
//  commentModel.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "commentModel.h"

@implementation commentModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self.nick = dict[@"nick"];
    self.userIcon = dict[@"userIcon"];
    self.content = dict[@"content"];
    return self;
}
@end
