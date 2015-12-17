//
//  NetworkDataAccess.h
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/25.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NetWorkAccessMethodGet,
    NetWorkAccessMethodPost
} NetWorkAccessMethod;

#define NETWORLACCESS_RESULT_OK 0




@interface NetworkDataAccess : NSObject

/*
 * param address        URL网址
 * param parameters     参数集合
 * param method         GET、POST
 * param handler        处理回调的BLOCK
 data            正确解析后的JSON数据对应的Dictionary或Array
 resultCode      如果是0，说明正确，否则表示错误代码
 resultMessage   错误信息
 innerError      内部的错误对象
 */
+(void) accessWithAddress:(NSString *)address
               parameters:(NSDictionary *)parameters
                   method:(NetWorkAccessMethod) method
        completionHandler:(void (^)(id data,int resultCode,NSString *resultMessage, NSError *innerError))handler;

@end
