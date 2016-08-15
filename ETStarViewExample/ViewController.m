//
//  ViewController.m
//  ETStarViewExample
//
//  Created by chenglei on 16/8/11.
//  Copyright © 2016年 ETListener. All rights reserved.
//

#import "ViewController.h"

#import "ETStarView.h"

@interface ViewController ()

@property (nonatomic, strong) ETStarView *masonryUntouchStarView;
@property (nonatomic, strong) ETStarView *masonryTouchStarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1111";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.masonryTouchStarView];
    [_masonryTouchStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.equalTo(self.view.mas_top).offset(200);
        make.size.mas_equalTo(CGSizeMake(kStarViewWidth, kStarViewHeight));
    }];
    
    [self.view addSubview:self.masonryUntouchStarView];
    [_masonryUntouchStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.equalTo(self.view.mas_top).offset(400);
        make.size.mas_equalTo(CGSizeMake(kStarViewWidth, kStarViewHeight));
    }];
}

#pragma mark - Getters UI
- (ETStarView *)masonryTouchStarView {
    if (!_masonryTouchStarView) {
        _masonryTouchStarView = [ETStarView creatMasonryLayoutWithRating:1 showStyle:BYStarViewYellowStarShowStyle_RoundInt];
        _masonryTouchStarView.canTouchSlide = YES;
        _masonryTouchStarView.isShowGrayStar = YES;
    }
    return _masonryTouchStarView;
}

- (ETStarView *)masonryUntouchStarView {
    if (!_masonryUntouchStarView) {
        _masonryUntouchStarView = [ETStarView creatMasonryLayoutWithRating:4 showStyle:BYStarViewYellowStarShowStyle_RoundInt];
    }
    return _masonryUntouchStarView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
