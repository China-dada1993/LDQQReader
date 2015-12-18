//
//  NetWorkCallbackDelegate.h
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/25.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkCallbackDelegate <NSObject>


- (void) callBackWithData:(id)data requestCode:(int)requestCode;

@optional
- (void) callBackWithErrorCode:(int)code message:(NSString *)message innerError:(NSError *)error requestCode:(int)requestCode;

@end