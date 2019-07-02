//
//  GTViewController.m
//  GridLayout
//
//  Created by 547188371@qq.com on 07/02/2019.
//  Copyright (c) 2019 547188371@qq.com. All rights reserved.
//

#import "GTViewController.h"
#import <Masonry/Masonry.h>
#import "NSArray+GridLayout.h"

@interface GTViewController ()

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = UIColor.blackColor;
    
    [self.view addSubview:contentView];
    
    for (int i=0; i < 9; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.redColor;
        [contentView addSubview:view];
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.centerOffset(CGPointZero);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(400);
    }];
    
    [contentView.subviews gridViewsAxis:GridAxisTypeHorizontal gridCount:5 fixedSpacing:16 lineSpacing:16 size:CGSizeMake(48, 28) insets:UIEdgeInsetsMake(16, 16, 16, 16)];
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo([contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
//    }];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
