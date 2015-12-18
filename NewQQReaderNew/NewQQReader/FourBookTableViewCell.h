//
//  FourBookTableViewCell.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookView.h"

@interface FourBookTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *sameAuthorModelList;
@property (nonatomic, strong) NSArray *othersReadedModelList;
@property (nonatomic, strong) NSArray *sameCategoryModelList;
@end
