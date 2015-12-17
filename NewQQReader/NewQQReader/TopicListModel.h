//
//  TopicListModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TopicModel.h"

@interface TopicListModel : JSONModel
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *readCnt;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *shareimg;
@end
