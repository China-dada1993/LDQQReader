//
//  ADSModel.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "ADSModel.h"

@implementation ADSModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"extInfo.desc":@"desc"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
