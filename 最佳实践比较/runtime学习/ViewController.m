//
//  ViewController.m
//  runtime学习
//
//  Created by qwkj on 2017/6/1.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "ViewController.h"
#import "Son+Swizzle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Son *aSon = [Son new];
    if ([aSon respondsToSelector:NSSelectorFromString(@"cry")]) {
        [aSon performSelector:NSSelectorFromString(@"cry")];
    }
//    if ([aSon respondsToSelector:NSSelectorFromString(@"dance")]) {
//        [aSon performSelector:NSSelectorFromString(@"dance")];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
