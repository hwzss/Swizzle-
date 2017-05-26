//
//  ViewController.m
//  Swizzle方法实现
//
//  Created by qwkj on 2017/5/26.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "ViewController.h"
#import "SecondController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
}

-(void)WZ_viewWillApper:(BOOL )animated{
    NSLog(@"加点附近拉伸；的");
   
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SecondController *secondVc = [[ SecondController alloc]init];
    [self.navigationController pushViewController:secondVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
