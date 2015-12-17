//
//  NetworkDataAccess.m
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/25.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "NetworkDataAccess.h"

@implementation NetworkDataAccess

+ (void)accessWithAddress:(NSString *)address parameters:(NSDictionary *)parameters method:(NetWorkAccessMethod)method completionHandler:(void (^)(id, int, NSString *, NSError *))handler {
    
    // 构建URL参数
    NSMutableArray *parameterCollection = [[NSMutableArray alloc] init];
    for (NSString *key in parameters.allKeys) {
        NSString *val = [parameters objectForKey:key];
        
        NSString *item = [NSString stringWithFormat:@"%@=%@", key, val];
        
        [parameterCollection addObject:item];
    }
    NSString *parameterString = nil;
    if (parameterCollection.count != 0) {
        parameterString = [parameterCollection componentsJoinedByString:@"&"];
    }
    
    // 若是GET方式，处理参数中的字符
    if (method == NetWorkAccessMethodGet && parameters != nil && parameters.count != 0) {
        //        iOS9中已过期
        //        parameterString = [parameterString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // 在iOS9中使用如下代码替代
        parameterString = [parameterString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        address = [NSString stringWithFormat:@"%@?%@",address,parameterString];
    }
//    NSLog(@"网络连接地址：%@", address);
    
    // 构建URLRequest
    NSURL *url = [NSURL URLWithString:address];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    
    if (method == NetWorkAccessMethodGet) {
        [request setHTTPMethod:@"GET"];
    }
    else {
        [request setHTTPMethod:@"POST"];
        if (parameters != nil && parameters.count != 0) {
            NSData *parameterData = [parameterString dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:parameterData];
        }
    }
    
    
    // iOS9中NSURLConnection过期，使用NSURLSession中的dataTask操作
    /*[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
     
     
     if (connectionError != nil) {
     //
     NSLog(@"网络连接错误");
     handler(nil, 1,@"网络连接错误", connectionError);
     }
     else {
     NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
     int statusCode = (int)resp.statusCode;
     if (statusCode != 200) {
     NSLog(@"网络访问错误，错误码：%d", statusCode);
     handler(nil, 2, [NSString stringWithFormat:@"网络访问错误，错误码：%d", statusCode], nil);
     }
     else {
     NSError *jsonError;
     id dataResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
     if (jsonError != nil) {
     NSLog(@"JSON解析错误");
     handler(nil, 3,@"JSON解析错误", jsonError);
     }
     else {
     handler(dataResult, 0,@"", nil);
     }
     }
     }
     
     }];*/
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse * response, NSError *error) {
        if (error != nil) {
            //
            NSLog(@"网络连接错误");
            handler(nil, 1,@"网络连接错误", error);
        }
        else {
            NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
            int statusCode = (int)resp.statusCode;
            if (statusCode != 200) {
                NSLog(@"网络访问错误，错误码：%d", statusCode);
                handler(nil, 2, [NSString stringWithFormat:@"网络访问错误，错误码：%d", statusCode], nil);
            }
            else {
                NSError *jsonError;
                id dataResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
                if (jsonError != nil) {
                    NSLog(@"JSON解析错误");
                    handler(nil, 3,@"JSON解析错误", jsonError);
                }
                else {
                    handler(dataResult, NETWORLACCESS_RESULT_OK, @"", nil);
                }
            }
        }
    }];
    [task resume];
}

@end
