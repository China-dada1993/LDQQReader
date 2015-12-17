//
//  BookTopicInfoFore1ImageModel.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "BookTopicInfoFore1ImageModel.h"
/*
 @property (nonatomic, strong) NSString *style;
 @property (nonatomic, strong) NSString *cmd;
 @property (nonatomic, strong) NSString *cmdvalue;
 @property (nonatomic, strong) NSString *desc;
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) NSString *url;
 */
@implementation BookTopicInfoFore1ImageModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"cmd.cmd":@"cmd", @"cmd.cmdvalue":@"cmdvalue", @"info.desc":@"desc", @"info.title":@"title", @"info.pics":@"urls"};
    //, @"info.pics.url":@"url"
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
