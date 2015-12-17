//
//  BookStackViewController.h
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/23.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StackDataControl.h"
#import "NetWorkCallbackDelegate.h"

@interface BookStackViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NetWorkCallbackDelegate>

@end
