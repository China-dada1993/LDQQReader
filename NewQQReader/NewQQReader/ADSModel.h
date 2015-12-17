//
//  ADSModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ADSModel : JSONModel
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *desc;
@end
