//
//  BookDetailItemModel.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "BookDetailItemModel.h"

/*
 detailmsg;
 @property (nonatomic, strong) NSString *bookScore;
 @property (nonatomic, strong) NSString *lastCname;
 @property (nonatomic, strong) NSString *lastChapterUpdateTime;
 @property (nonatomic, strong) NSString *chapSize;
 */
@implementation BookDetailItemModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dictionary = @{
                                 @"detailmsg.detailmsg":@"detailmsg",
                                 @"introInfo.bookScore":@"bookScore",
                             @"introInfo.chapinfo.lastCname":@"lastCname",
                             @"introInfo.chapinfo.lastChapterUpdateTime":@"lastChapterUpdateTime",
                             @"introInfo.chapinfo.chapSize":@"chapSize"
                                 };
    return [[JSONKeyMapper alloc]initWithDictionary:dictionary];
}

@end
