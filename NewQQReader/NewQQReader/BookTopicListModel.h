//
//  BookTopicListModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BookTopicInfoModel.h"

@interface BookTopicListModel : JSONModel
@property (nonatomic, strong) NSArray<BookTopicInfoModel> *books;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cmd;
@property (nonatomic, strong) NSString *cmdvalue;
@property (nonatomic, assign) NSInteger style;
@end
