//
//  SelectBookModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SelectBookModel : JSONModel
@property (nonatomic, strong) NSString *cmd;
@property (nonatomic, strong) NSString *cmdvalue;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *catel2name;
@property (nonatomic, strong) NSString *catel3name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *wordcount;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) NSInteger style;
@end
