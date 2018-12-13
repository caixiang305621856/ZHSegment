//
//  ZHSegmentBarConfig.h
//  ZHSement
//
//  Created by caixiang on 2017/11/10.
//  Copyright © 2017年 caixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,ZHSegmentBarConfigType) {
    ZHSegmentBarConfigTypeNormarl = 0,
    ZHSegmentBarConfigTypeSizeToFitLeft = 1
};
@interface ZHSegmentBarConfig : NSObject

+ (instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *segmentBarBackgroundColor;

@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemSelectColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, assign) CGFloat itemMinMargin;

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat indicatorHeight;
@property (nonatomic, assign) CGFloat indicatorExtraW;
@property (assign, nonatomic) ZHSegmentBarConfigType segmentBarConfigType;
@end
