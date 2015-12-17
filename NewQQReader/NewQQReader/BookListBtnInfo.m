//
//  BookListBtnInfo.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "BookListBtnInfo.h"


@interface BookListBtnInfo ()
@end

@implementation BookListBtnInfo
{
    
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    self.title = dict[@"title"];
    self.actionId = dict[@"actionId"];
    return self;
}
@end
