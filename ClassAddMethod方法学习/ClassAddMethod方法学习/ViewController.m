//
//  ViewController.m
//  ClassAddMethod方法学习
//
//  Created by qwkj on 2017/6/6.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

- (void)WZ_noImpMethod;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

void MyMethodIMP(id self, SEL _cmd)
{
    NSLog(@"新的方法实现");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{


}

- (void)learn_ClassAddMethod{
    //一个声明了但却没有实现的方法，父类中也没有，返回nil
    Method noImpMethod = class_getInstanceMethod([self class], @selector(WZ_noImpMethod));
    //添加一个已经实现的方法会添加失败，具体测试，线执行一下下面的方法，然后再执行一下就会添加失败了
    
    
    //添加一个声明了但没有实现的方法
    BOOL didAddNoIMPMethod = class_addMethod([self class], @selector(WZ_noImpMethod), (IMP) MyMethodIMP, "V@:");
    if (didAddNoIMPMethod)
    {
        NSLog(@"添加成功");
        [self WZ_noImpMethod];
    }
    else
    {
        NSLog(@"添加失败");
    }
    //添加一个没有声明的方法
    BOOL didAdd = class_addMethod([self class], NSSelectorFromString(@"WZ_aMethod"), (IMP) MyMethodIMP, "V@:");
    if (didAdd)
    {
        NSLog(@"添加成功");
        [self performSelector:NSSelectorFromString(@"WZ_aMethod")];
    }
    else
    {
        NSLog(@"添加失败");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
