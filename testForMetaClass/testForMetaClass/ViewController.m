//
//  ViewController.m
//  testForMetaClass
//
//  Created by cc on 15/8/17.
//  Copyright (c) 2015年 cc. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    Person *person = [[Person alloc] init];
    unsigned int outCount = 0;
    Class cls = person.class;   //得到Person的class
    //--------------------类名
    NSLog(@"类名是 :%s",class_getName(cls));
    //-----------父类
    NSLog(@"父类名是:%s",class_getName(class_getSuperclass(cls)));
    
    //是否是元类
    if (class_isMetaClass(cls)) {
        NSLog(@"Person是元类");
    }else
    {
        NSLog(@"Person不是元类");
    }
    //返回指定类的元类
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%ss 的元类 是 %s",class_getName(cls),class_getName(meta_class));
    
    //变量实例大小  %zu用来输出size_t类型的。
    NSLog(@"实例大小：:%zu",class_getInstanceSize(cls));
    
    //成员变量 Iavr:一个不透明的类型代表实例变量。这里可以得到其所有的成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i=0;i<outCount;i++)
    {
        Ivar ivar = ivars[i];
        NSLog(@"实例变量的名字：%s at index %d",ivar_getName(ivar),i);
    }
    free(ivars);    //释放成员变量实例
    //通过名字：获取指定的实例变量，，比如我想获取该类是否有_name这个变量就可以通过该方法获得。
    Ivar string = class_getInstanceVariable(cls, "_name");
    if (string!=NULL) {
        NSLog(@"%s有实列变量：%s",class_getName(cls),ivar_getName(string));
    }else
    {
        NSLog(@"%s没有指定的实列变量：%s",class_getName(cls),ivar_getName(string));
    }
    
    
    //属性操作:objc_porperty：代表公开的属性.class_getProperty的参数中：cls代表该类的class，name是该类的属性
    objc_property_t array = class_getProperty(cls, "name");
    if (array!=NULL) {
        NSLog(@"属性：%s",property_getName(array));
    }
    //方法操作：
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i=0; i<outCount; i++) {
        Method method = methods[i];
        NSLog(@"方法签名是：%s",sel_getName(method_getName(method)));   //sel_getName:得到方法名字
    }
    free(methods);   //释放methods所占用的内存
    //    typedef struct objc_method *Method;
    //这里得到的是类方法
    //    struct objc_method {
    //        SEL method_name                                          OBJC2_UNAVAILABLE;
    //        char *method_types                                       OBJC2_UNAVAILABLE;
    //        IMP method_imp                                           OBJC2_UNAVAILABLE;
    //    }
    //IMP
    
    Method classMethod = class_getClassMethod(cls, @selector(method1));
    if (classMethod!=NULL) {
        NSLog(@"%s 有该类方法：%s",class_getName(cls),sel_getName(method_getName(classMethod)));
    }else
    {
        NSLog(@"%s 没有该类方法：%s",class_getName(cls),sel_getName(method_getName(classMethod)));
    }
    
    //判断类的实例是否相应某个方法：比如alloc就不响应，而init就相应
    if (class_respondsToSelector(cls, @selector(alloc))) {
        NSLog(@"Person实例 响应 alloc");
    }else
    {
        NSLog(@"Person实例 不响应 alloc");
    }
    //函数指针
    IMP imp = class_getMethodImplementation(cls, @selector(eat));
    imp();
    //获得该类具有的协议
    Protocol *__unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol *protocol;
    for (int i=0; i<outCount; i++) {
        protocol = protocols[i];
        NSLog(@"协议名称：%s",protocol_getName(protocol));
    }
    //判断是否遵守协议
    if (class_conformsToProtocol(cls, protocol)) {
        NSLog(@"Person遵守协议%s",protocol_getName(protocol));
    }else
    {
        NSLog(@"Person不遵守协议%s",protocol_getName(protocol));
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
