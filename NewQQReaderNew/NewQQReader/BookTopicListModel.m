//
//  BookTopicListModel.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "BookTopicListModel.h"
/*@property (nonatomic, strong) NSArray<BookTopicInfoModel> *books;
 @property (nonatomic, strong) NSString *desc;
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) NSString *cmd;
 @property (nonatomic, strong) NSString *cmdvalue;
 */
@implementation BookTopicListModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"info.desc":@"desc", @"info.title":@"title", @"info.books":@"books", @"cmd.cmd":@"cmd", @"cmd.cmdvalue":@"cmdvalue"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
