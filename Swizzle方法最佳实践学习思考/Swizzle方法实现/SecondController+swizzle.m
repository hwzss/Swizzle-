//
//  SecondController+swizzle.m
//  Swizzle方法实现
//
//  Created by qwkj on 2017/5/26.
//  Copyright © 2017年 qwkj. All rights reserved.
//

#import "SecondController+swizzle.h"

#import <objc/runtime.h>

void myMethodIMP(id self, SEL _cmd)
{
    // implementation ....
}
void classSetNullImp(Method method){
    method_setImplementation(method, imp_implementationWithBlock(^(id obj,BOOL animated){
        printf("一个空实现");
    }));
}

BOOL classInstanceMethodSwizzle(Class aClass, SEL originalSel, SEL swizzleSel){
    
    Method originalMethod = class_getInstanceMethod(aClass, originalSel);
    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSel);
    
    //***
//    method_exchangeImplementations(originalMethod, swizzleMethod);//如果就写这一句，当secontroller未实现originalMethod方法时，会从父类找方法进行实现，所以就会替换掉UIViewController的方法。然后你又在WZ_viewWillApper调用了 [self WZ_viewWillApper:animated];。当父类方法执行viewWillApper时就会出现找不到WZ_viewWillApper错误❌
    //***
    
    BOOL didAddMethod = class_addMethod(aClass, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));//首先给本类的originalSel添加实现，如果本类已经有该方法就不会添加实现，如果没有则将这个实现添加到里面。由于一般我们Swizzley一个方法，默认会在插入的方法里调用到自己的实现方法里，所以如果这里成功将swizzleMethod的imp赋值给了originalMethod，这时originalMethod会调用swizzleMethod了，而swizzleMethod如果还是我们原来的实现就会出现自己调用自己，导致死循环，所以就要将swizzleMethod赋值为空实现（当然也可以替换为该类父类的实现，毕竟很多默认方法子类实现时都需要调用super方法。），所以你可以给他一个空IMP，也可以给他一个父类的IMP。//当然若你的swizzleSel替换前IMP里没有调用自己，就没必要赋值空或其他实现了
    
    if (didAddMethod) {
        
        //在这里如果didAddMethod=yes了说明子类没有实现该方法，class_getInstanceMethod就会从父类，父类没找到往父类的父类，直到根类进行方法查找。所以originalMethod应该是某一个父类级别的方法。下面代码就是将父类的实现给swizzleSel。当然如果所有的上面的父类都找不到实现，这里就是空IMP
         class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        
        //如果想赋值空实现。最好直接赋值空
//        classSetNullImp(swizzleMethod);

    }else{
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
    
    return YES;
}

@implementation SecondController (Swizzle)


+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classInstanceMethodSwizzle([self class], @selector(viewWillAppear:), @selector(WZ_viewWillApper:));
    });
}

-(void)WZ_viewWillApper:(BOOL )animated{
    NSLog(@"哈哈哈");
    [self WZ_viewWillApper:animated];
}

@end
