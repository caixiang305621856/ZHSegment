# ZHSement

[![CI Status](http://img.shields.io/travis/caixiang/ZHSement.svg?style=flat)](https://travis-ci.org/caixiang/ZHSement)
[![Version](https://img.shields.io/cocoapods/v/ZHSement.svg?style=flat)](http://cocoapods.org/pods/ZHSement)
[![License](https://img.shields.io/cocoapods/l/ZHSement.svg?style=flat)](http://cocoapods.org/pods/ZHSement)
[![Platform](https://img.shields.io/cocoapods/p/ZHSement.svg?style=flat)](http://cocoapods.org/pods/ZHSement)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
```objc
//设置frame
self.segmentViewController.segmentBar.frame = CGRectMake(0, 0, self.view.width, 50);
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
```

## Requirements

## Installation

ZHSement is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZHSement'
```

## Author

caixiang, caix@mail.open.cn

## License

ZHSement is available under the MIT license. See the LICENSE file for more info.
