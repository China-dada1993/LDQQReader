//
//  BookListBtnInfo.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookListBtnInfo : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *actionId;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
