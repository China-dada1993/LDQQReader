//
//  BookListViewController.h
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/25.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookListViewController : UIViewController<UIPopoverPresentationControllerDelegate>
@property (nonatomic, strong) NSString *actionId;
@property (nonatomic, strong) NSString *bookListTitle;

@end
