//
//  ZHSegmentBar.m
//  ZHSement
//
//  Created by caixiang on 2017/11/10.
//  Copyright © 2017年 caixiang. All rights reserved.
//

#import "ZHSegmentBar.h"
#import "ZHSegmentBarConfig.h"
#import "UIView+ZHSegmentPostion.h"

@interface ZHSegmentBar () {
    UIButton *_selectButton;
}
#pragma mark - Data Perproty
@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;
@property (nonatomic, strong) ZHSegmentBarConfig *config;
#pragma mark - UI Perproty
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIView *indicatorView;

@end
@implementation ZHSegmentBar

#pragma mark - public
+ (instancetype)segmentBarWithFrame: (CGRect)frame {
    ZHSegmentBar *segmentBar = [[ZHSegmentBar alloc] initWithFrame:frame];
    return segmentBar;
}

#pragma mark - life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = self.config.segmentBarBackgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    CGFloat caculateMargin = (self.width - totalBtnWidth) / (self.items.count + 1);
    if (caculateMargin < self.config.itemMinMargin) {
        caculateMargin = self.config.itemMinMargin;
    }
    if (self.config.segmentBarConfigType == ZHSegmentBarConfigTypeSizeToFitLeft) {
        caculateMargin = self.config.itemMinMargin;
    }
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        btn.y =  self.contentView.height/2 - btn.height/2;
        btn.x = lastX;
        lastX += btn.width + caculateMargin;
    }
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    if (self.itemBtns.count == 0) {
        return;
    }
    if (self.selectIndex < self.itemBtns.count) {
        UIButton *btn = self.itemBtns[self.selectIndex];
        self.indicatorView.width = btn.width + self.config.indicatorExtraW * 2;
        self.indicatorView.centerX = btn.centerX;
        self.indicatorView.height = self.config.indicatorHeight;
        self.indicatorView.y = self.height - self.indicatorView.height;
        self.indicatorView.layer.cornerRadius = self.config.indicatorCorner;
    }
}

- (void)updateWithConfig: (void(^)(ZHSegmentBarConfig *config))configBlock {
    if (configBlock) {
        configBlock(self.config);
    }
    [self setup];
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
    }
    self.indicatorView.backgroundColor = self.config.indicatorColor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - private
- (void)buttonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:sender.tag fromIndex:_selectButton.tag];
    }
    _selectIndex = sender.tag;
    _selectButton.selected = NO;
    _selectButton.titleLabel.font = self.config.itemFont;
    
    sender.selected = YES;
    _selectButton = sender;
    _selectButton.titleLabel.font = self.config.itemSelectFont;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.width = sender.width + self.config.indicatorExtraW * 2;
        self.indicatorView.centerX = sender.centerX;
    }];
    CGFloat scrollX = sender.centerX - self.contentView.width * 0.5;
    if (scrollX > self.contentView.contentSize.width - self.contentView.width) {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    if (scrollX < 0) {
        scrollX = 0;
    }
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
    
    if (self.config.itemFont != self.config.itemSelectFont) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}


#pragma mark - getter & setter
- (void)setSelectIndex:(NSInteger)selectIndex {
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self buttonClick:btn];
}

- (void)setItems:(NSArray<NSString *> *)items {
    _items = items;
    
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    // 根据所有的选项数据源， 创建Button, 添加到内容视图
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (NSMutableArray<UIButton *> *)itemBtns {
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat indicatorH = self.config.indicatorHeight;
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        _indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (ZHSegmentBarConfig *)config {
    if (!_config) {
        _config = [ZHSegmentBarConfig defaultConfig];
    }
    return _config;
}

@end
