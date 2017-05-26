//
//  GrandParentViewController.m
//  Swizzle方法实现
//
//  Created by qwkj on 2017/5/26.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "GrandParentViewController.h"

@interface GrandParentViewController ()

@end

@implementation GrandParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"我是祖父类。如果子类swizzle该方法时，但子类游没有实现，所以Method originalMethod = class_getInstanceMethod(aClass, originalSel);就会获得我的方法，class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));就会将我的实现给swizzleSel");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
