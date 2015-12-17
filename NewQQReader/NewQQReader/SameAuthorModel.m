//
//  sameAuthorModel.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "SameAuthorModel.h"

@implementation SameAuthorModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self.cover = dict[@"cover"];
    self.title = dict[@"title"];
    return self;
}
@end
