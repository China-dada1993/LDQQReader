//
//  UrlModel.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol UrlModel <NSObject>


@end
@interface UrlModel : JSONModel
@property (nonatomic, strong) NSString *url;
@end
