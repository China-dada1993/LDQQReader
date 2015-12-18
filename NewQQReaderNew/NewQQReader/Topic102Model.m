//
//  Topic102Model.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "Topic102Model.h"

@implementation Topic102Model
+ (JSONKeyMapper *)keyMapper {
    /*
     @property (nonatomic, strong) NSString *cover;
     @property (nonatomic, strong) NSString *bid;
     @property (nonatomic, strong) NSString *author;
     @property (nonatomic, strong) NSString *categoryShortName;
     @property (nonatomic, strong) NSString *intro;
     @property (nonatomic, strong) NSString *title;
     @property (nonatomic, strong) NSString *free;
     @property (nonatomic, strong) NSString *totalWords;
     @property (nonatomic, strong) NSString *lastChapter;
     */
    NSDictionary *dict = @{@"book.cover":@"cover", @"book.bid":@"bid", @"book.author":@"author", @"book.categoryShortName":@"categoryShortName", @"book.intro":@"intro", @"book.title":@"title", @"book.free":@"free", @"book.totalWords":@"totalWords", @"book.lastChapter":@"lastChapter"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
