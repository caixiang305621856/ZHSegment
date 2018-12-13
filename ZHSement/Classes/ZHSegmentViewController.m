//
//  ZHSegmentViewController.m
//  ZHSement
//
//  Created by caixiang on 2017/11/10.
//  Copyright © 2017年 caixiang. All rights reserved.
//

#import "ZHSegmentViewController.h"
#import "UIView+ZHSegmentPostion.h"

@interface ZHSegmentViewController ()<ZHSegmentBarDelegate,UIScrollViewDelegate>
#pragma mark - UI Perproty
@end

@implementation ZHSegmentViewController
#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (self.segmentBar.superview == self.view) {
        //defult
        self.segmentBar.frame = CGRectMake(0, 0, self.view.width, 35);
        CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
        self.contentView.frame = contentFrame;
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
        return;
    }
    CGRect contentFrame = CGRectMake(0, 0,self.view.width,self.view.height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    self.segmentBar.selectIndex = index;
}

#pragma mark - ZHSegmentBarDelegate
- (void)segmentBar:(ZHSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex {
    [self showChildVCViewsAtIndex:toIndex];
}

#pragma mark - public
- (void)setUpWithItems: (NSArray <NSString *>*)items childViewControllers: (NSArray <UIViewController *>*)childViewControllers {
    self.segmentBar.items = items;
    //会有个bug 就是vc被移除后，View 没被移除  现在就直接隐藏
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.view.hidden = YES;
    }];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [childViewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
    }];
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    self.segmentBar.selectIndex = 0;
}

#pragma mark - private
- (void)showChildVCViewsAtIndex: (NSInteger)index {
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    vc.view.hidden = NO;
    [self.contentView addSubview:vc.view];
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.width, 0) animated:YES];
}

#pragma mark - getter & setter
- (ZHSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [ZHSegmentBar segmentBarWithFrame:CGRectZero];
        _segmentBar.delegate = self;
        _segmentBar.backgroundColor = [UIColor brownColor];
        [self.view addSubview:_segmentBar];
    }
    return _segmentBar;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.delegate = self;
        _contentView.pagingEnabled = YES;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

@end
