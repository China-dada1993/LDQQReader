//
//  sameAuthorModel.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SameAuthorModel : NSObject
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
