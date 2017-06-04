# Swizzle-
一次关于swizzle最佳实践的思考
一直在使用swizzle时对别人swzzle代码代码有点问题为什么要用下面的代码，到底是做什么。

```
 Method originalMethod = class_getInstanceMethod(aClass, originalSel);
    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSel);
    BOOL didAddMethod = class_addMethod(aClass, originalSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
         class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
```
demo中就是对此进行探讨

# 更新补充
上面的最佳实践方式，个人感觉并不是最佳，因为在需要替换的originalSel在本类以及本类的父类往上一直没有过该方法的实现时，通过上面方式进行swizzle会出现问题，originalMethod为nil，导致class_replaceMethod(aClass, swizzleSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));代码失效没有任何作用



