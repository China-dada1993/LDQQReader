//
//  TopicListModel.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "TopicListModel.h"
/*
 @property (nonatomic, strong) NSArray<TopicModel> *books;
 @property (nonatomic, strong) NSString *shareimg;
 @property (nonatomic, strong) NSString *intro;
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) NSString *readCnt;
 @property (nonatomic, strong) NSString *createTime;
 */
@implementation TopicListModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"topic.intro":@"intro", @"topic.shareimg":@"shareimg", @"topic.title":@"title",@"topic.createTime":@"createTime"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
