//
//  BookTopicInfoModel.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "BookTopicInfoModel.h"
/*@property (nonatomic, strong) NSString *bid;
 @property (nonatomic, strong) NSString *index;
 @property (nonatomic, strong) NSString *title;*/
@implementation BookTopicInfoModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"bid":@"bid", @"index":@"index", @"title":@"title"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end
