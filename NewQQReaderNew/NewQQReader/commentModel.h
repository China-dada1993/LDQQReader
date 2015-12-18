//
//  commentModel.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "JSONModel.h"

@protocol commentModel <NSObject>

@end

@interface commentModel : JSONModel
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userIcon;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
