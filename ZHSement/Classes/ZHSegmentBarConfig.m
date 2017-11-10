//
//  ZHSegmentBarConfig.m
//  ZHSement
//
//  Created by caixiang on 2017/11/10.
//  Copyright © 2017年 caixiang. All rights reserved.
//

#import "ZHSegmentBarConfig.h"

@implementation ZHSegmentBarConfig

+ (instancetype)defaultConfig {
    ZHSegmentBarConfig *config = [[ZHSegmentBarConfig alloc] init];
    config.segmentBarBackgroundColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:15];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    config.itemMinMargin = 30;
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 10;
    return config;
}


@end
