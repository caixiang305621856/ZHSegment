//
//  ZHSegmentBar.h
//  ZHSement
//
//  Created by caixiang on 2017/11/10.
//  Copyright © 2017年 caixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHSegmentBarConfig.h"

@class ZHSegmentBar;
@protocol ZHSegmentBarDelegate <NSObject>

- (void)segmentBar:(ZHSegmentBar *)segmentBar
    didSelectIndex:(NSInteger )toIndex
         fromIndex:(NSInteger)fromIndex;
@end

@interface ZHSegmentBar : UIView

+ (instancetype)segmentBarWithFrame: (CGRect)frame;

@property (nonatomic, weak) id<ZHSegmentBarDelegate> delegate;
/**
 数据源
 */
@property (nonatomic, strong) NSArray <NSString *>*items;
/**
 当前选中的索引
 */
@property (nonatomic, assign) NSInteger selectIndex;

- (void)updateWithConfig: (void(^)(ZHSegmentBarConfig *config))configBlock;

@end
