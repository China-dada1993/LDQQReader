//
//  TopicBookList.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "TopicBookList.h"

@implementation TopicBookList
+(JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"books":@"bookList"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict] ;
}
@end
