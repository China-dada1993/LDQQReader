//
//  BookModel.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "JSONModel.h"

@interface BookModel : JSONModel
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *showPrice;
@property (nonatomic, strong) NSString *sortValue;
@property (nonatomic, strong) NSString *title;
@end
