//
//  Topic102Model.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol  Topic102Model <NSObject>


@end
@interface Topic102Model : JSONModel
@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *categoryShortName;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *free;
@property (nonatomic, strong) NSString *totalWords;
@property (nonatomic, strong) NSString *lastChapter;

@end
