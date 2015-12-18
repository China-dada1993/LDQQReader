//
//  TopicBookList.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Topic102Model.h"

@interface TopicBookList : JSONModel
@property (nonatomic, strong) NSArray *bookList;
@property (nonatomic, strong) NSString *title;
@end
