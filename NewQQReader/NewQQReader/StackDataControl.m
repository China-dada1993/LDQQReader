//
//  StackDataControl.m
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/25.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "StackDataControl.h"
#import "ApplicationJsonMetaData.h"
#import "ApplicationNetworkMetaData.h"

#import "NetworkDataAccess.h"

#import "CategoryDataInfo.h"
#import "CategoyItemInfo.h"

@implementation StackDataControl

+ (void)getCategoryListWithflag:(NSInteger)flag requestCode:(int)requestCode callBackDelegate:(id<NetWorkCallbackDelegate>)callBackDelegate {
    
    NSString *address = [NSString stringWithFormat:@"%@%@", HOST_NAME, CATEGORY];
    
    NSNumber *flagNumber = [NSNumber numberWithInteger:flag];
    NSDictionary *parameters = @{PARAMETER_CATEGORY_FLAG: flagNumber};
    
    [NetworkDataAccess accessWithAddress:address parameters:parameters method:NetWorkAccessMethodGet completionHandler:^(id data, int resultCode, NSString *resultMessage, NSError *innerError) {
        if (resultCode == NETWORLACCESS_RESULT_OK) {
            // 成功
            NSDictionary *dictionary = (NSDictionary *)data;
            
            CategoryDataInfo *allCategoryData = [[CategoryDataInfo alloc] init];
            
            allCategoryData.allBookCount = [[[dictionary objectForKey:@"count"] objectForKey:@"bookCount"] integerValue];
            allCategoryData.newBookCount = [[[dictionary objectForKey:@"count"] objectForKey:@"newBookCount"] integerValue];
            
            if (flag == 1) {
                allCategoryData.lineTitle    = [[dictionary objectForKey:@"line"] objectForKey:@"title"];
                
                
                NSArray *boyData = [dictionary objectForKey:@"boyCategoryList"];
                NSMutableArray *boyCategoryListData = [[NSMutableArray alloc] init];
                for (NSDictionary *itemData in boyData) {
                    CategoyItemInfo *itemInfo = [[CategoyItemInfo alloc] init];
                    
                    itemInfo.actionId       = [[itemData objectForKey:@"actionId"]integerValue];
                    itemInfo.categoryName   = [itemData objectForKey:@"categoryName"];
                    itemInfo.categoryL3Name = [itemData objectForKey:@"level3categoryName"];
                    itemInfo.bookCount      = [[itemData objectForKey:@"bookCount"] integerValue];
                    itemInfo.imageName      = [itemData objectForKey:@"img"];
                    
                    [boyCategoryListData addObject:itemInfo];
                }
                allCategoryData.boyCategoryList = boyCategoryListData;
                
                NSArray *girlData = [dictionary objectForKey:@"girlCategoryList"];
                NSMutableArray *girlCategoryListData = [[NSMutableArray alloc] init];
                for (NSDictionary *itemData in girlData) {
                    CategoyItemInfo *itemInfo = [[CategoyItemInfo alloc] init];
                    
                    itemInfo.actionId = [[itemData objectForKey:@"actionId"]integerValue];
                    itemInfo.categoryName = [itemData objectForKey:@"categoryName"];
                    itemInfo.categoryL3Name = [itemData objectForKey:@"level3categoryName"];
                    itemInfo.bookCount = [[itemData objectForKey:@"bookCount"] integerValue];
                    itemInfo.imageName = [itemData objectForKey:@"img"];
                    
                    [girlCategoryListData addObject:itemInfo];
                }
                allCategoryData.girlCategoryList = girlCategoryListData;
            }
            else {
                NSArray *publishData = [dictionary objectForKey:@"publishCategoryList"];
                NSMutableArray *publishCategoryListData = [[NSMutableArray alloc] init];
                for (NSDictionary *itemData in publishData) {
                    CategoyItemInfo *itemInfo = [[CategoyItemInfo alloc] init];
                    
                    itemInfo.actionId       = [[itemData objectForKey:@"actionId"]integerValue];
                    itemInfo.categoryName   = [itemData objectForKey:@"categoryName"];
                    itemInfo.categoryL3Name = [itemData objectForKey:@"level3categoryName"];
                    itemInfo.bookCount      = [[itemData objectForKey:@"bookCount"] integerValue];
                    itemInfo.imageName      = [itemData objectForKey:@"img"];
                    
                    [publishCategoryListData addObject:itemInfo];
                }
                allCategoryData.publishCategoryList = publishCategoryListData;
            }
            
            if (callBackDelegate) {
                [callBackDelegate callBackWithData:allCategoryData requestCode:requestCode];
            }
        }
        else {
            // 错误
            if (callBackDelegate) {
                [callBackDelegate callBackWithErrorCode:resultCode message:resultMessage innerError:innerError requestCode:requestCode];
            }
        }
    }];
}
//http://ios.reader.qq.com/v5_0/listdispatch?action=category&actionTag=0&actionId=20001&page=1

@end
