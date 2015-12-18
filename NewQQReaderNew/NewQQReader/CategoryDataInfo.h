//
//  CategoryDataInfo.h
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/24.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryDataInfo : NSObject

@property NSArray *boyCategoryList;
@property NSArray *girlCategoryList;
@property NSArray *publishCategoryList;

@property NSInteger allBookCount;
@property NSInteger newBookCount;

@property NSString *lineTitle;

@end
