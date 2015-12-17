//
//  BookTopicInfoModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BookTopicInfoModel <NSObject>

@end

@interface BookTopicInfoModel : JSONModel
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *title;
@end
