//
//  SelectBookModel.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "SelectBookModel.h"
/*
 @property (nonatomic, strong) NSString *cmd;
 @property (nonatomic, strong) NSString *cmdvalue;
 @property (nonatomic, strong) NSString *bid;
 @property (nonatomic, strong) NSString *catel2name;
 @property (nonatomic, strong) NSString *catel3name;
 @property (nonatomic, strong) NSString *desc;
 @property (nonatomic, strong) NSString *wordcount;
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) NSString *author;
 */
@implementation SelectBookModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"cmd.cmd":@"cmd", @"cmd.cmdvalue":@"cmdvalue", @"info.author":@"author", @"info.catel2name":@"catel2name", @"info.catel3name":@"catel3name",
        @"info.desc":@"desc", @"info.bid":@"bid", @"info.title":@"title", @"info.wordcount":@"wordcount"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
