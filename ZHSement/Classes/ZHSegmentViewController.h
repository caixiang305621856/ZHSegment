//
//  ZHSegmentViewController.h
//  ZHSement
//
//  Created by caixiang on 2017/11/10.
//  Copyright © 2017年 caixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHSegmentBar.h"

@interface ZHSegmentViewController : UIViewController

@property (nonatomic, strong) ZHSegmentBar *segmentBar;

- (void)setUpWithItems: (NSArray <NSString *>*)items childViewControllers: (NSArray <UIViewController *>*)childViewControllers;

@end
