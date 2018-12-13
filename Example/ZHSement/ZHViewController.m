//
//  ZHViewController.m
//  ZHSement
//
//  Created by caixiang on 11/10/2017.
//  Copyright (c) 2017 caixiang. All rights reserved.
//

#import "ZHViewController.h"
#import "ZHSegmentViewController.h"
#import "UIView+ZHSegmentPostion.h"

@interface ZHViewController ()

@property (nonatomic, weak) ZHSegmentViewController *segmentViewController;

@end

@implementation ZHViewController

- (ZHSegmentViewController *)segmentViewController{
    if (!_segmentViewController) {
        ZHSegmentViewController *segmentViewController = [[ZHSegmentViewController alloc] init];
        [self addChildViewController:segmentViewController];
        _segmentViewController = segmentViewController;
    }
    return _segmentViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置frame
    self.segmentViewController.segmentBar.frame = CGRectMake(0, 0, self.view.width, 100);
    self.segmentViewController.view.frame = CGRectMake(0, self.segmentViewController.segmentBar.height, self.view.width, self.view.height - self.segmentViewController.segmentBar.height);
    [self.view addSubview:self.segmentViewController.view];
    [self.view addSubview:self.segmentViewController.segmentBar];
    
    //配置数据源
    NSArray *items = @[@"标签1", @"标签2", @"标签3",@"标签标签4", @"标签5"];
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor colorWithRed:0.419 green:0.781 blue:0.977 alpha:1.000];
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor colorWithRed:0.957 green:0.557 blue:0.231 alpha:1.000];
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor colorWithWhite:0.729 alpha:1.000];
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor colorWithWhite:0.890 alpha:1.000];
    UIViewController *vc5 = [UIViewController new];
    vc5.view.backgroundColor = [UIColor colorWithRed:0.979 green:0.378 blue:0.328 alpha:1.000];
    [self.segmentViewController setUpWithItems:items childViewControllers:@[vc1,vc2,vc3,vc4,vc5]];
    
    //通过ZHSegmentBarConfig改变self.segmentViewController.segmentBar UI
    [self.segmentViewController.segmentBar updateWithConfig:^(ZHSegmentBarConfig *config) {
       config.itemSelectColor = [UIColor yellowColor];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
