//
//  BookDetailItemModel.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "JSONModel.h"

@interface BookDetailItemModel : JSONModel
@property (nonatomic, strong) NSString *detailmsg;
@property (nonatomic, strong) NSString *bookScore;
@property (nonatomic, strong) NSString *lastCname;
@property (nonatomic, strong) NSString *lastChapterUpdateTime;
@property (nonatomic, strong) NSString *chapSize;

@end
