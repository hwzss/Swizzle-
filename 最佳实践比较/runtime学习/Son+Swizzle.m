//
//  Son+Swizzle.m
//  runtime学习
//
//  Created by qwkj on 2017/6/4.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "Son+Swizzle.h"
#import <objc/runtime.h>

@implementation Son (Swizzle)

BOOL classSwizzleInstanceMethod(Class aClass, SEL originalSel,SEL swizzleSel){
    
    Method originalMethod = class_getInstanceMethod(aClass, originalSel);
    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSel);
    BOOL didAddMethod = class_addMethod(aClass, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
    
    return YES;
}
BOOL safeClassSwizzleInstanceMethod(Class aClass, SEL originalSel,SEL swizzleSel){
    
    Method originalMethod = class_getInstanceMethod(aClass, originalSel);
    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSel);
    if (!originalMethod) {
        class_addMethod(aClass, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        method_setImplementation(swizzleMethod, imp_implementationWithBlock(^(){
//              NSLog(@"%s",__func__);
//            NSLog(@"哈哈哈");
        }));
    }else{
        BOOL didAddMethod = class_addMethod(aClass, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        if (didAddMethod) {
            class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzleMethod);
        }
    }
    return YES;
}
+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换一个自己类以及父类中都没有实现的方法，由于从copymethodlist方法找不到cry，所以originalMethod为nil。class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));将不做任何事，所以swizzleMethod方法还是默认实现，就会照成死循环
//        classSwizzleInstanceMethod([self class], NSSelectorFromString(@"cry"), @selector(WZ_cry));
        
        //替换一个父类以及子类中都没有的方法，比如delegate方法，一般父类子类没有实现该代理方法的情况下。将替换后的方法实现置为空实现
        safeClassSwizzleInstanceMethod([self class], NSSelectorFromString(@"cry"), @selector(WZ_cry));
        
        
        //父类的父类有方法实现，最佳实践可行，成功替换
//        classSwizzleInstanceMethod([self class], @selector(dance), @selector(WZ_dance));
    });
}

-(void)WZ_dance{
    [self WZ_dance];
    
    NSLog(@"son 也会跳舞");
}

-(void)WZ_cry{
    NSLog(@"我是分类WZ_Cry方法IMP");
    [self WZ_cry];
}
@end
