//
//  StackDataControl.h
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/25.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkCallbackDelegate.h"

@interface StackDataControl : NSObject

+ (void)getCategoryListWithflag:(NSInteger) flag requestCode:(int)requestCode
               callBackDelegate:(id<NetWorkCallbackDelegate>)callBackDelegate;



@end
