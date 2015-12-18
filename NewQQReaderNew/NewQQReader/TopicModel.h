//
//  TopicModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol TopicModel <NSObject>

@end

@interface TopicModel : JSONModel
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *categoryShortName;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *totalWords;
@property (nonatomic, strong) NSString *lastChapter;
@end
