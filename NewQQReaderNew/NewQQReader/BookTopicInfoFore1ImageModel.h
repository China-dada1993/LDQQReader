//
//  BookTopicInfoFore1ImageModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "UrlModel.h"

@interface BookTopicInfoFore1ImageModel : JSONModel
@property (nonatomic, assign) NSInteger style;
@property (nonatomic, strong) NSString *cmd;
@property (nonatomic, strong) NSString *cmdvalue;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<UrlModel> *urls;
@end
