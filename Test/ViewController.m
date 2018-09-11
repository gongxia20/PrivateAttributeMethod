//
//  ViewController.m
//  Test
//
//  Created by James on 2018/6/29.
//  Copyright © 2018年 TZ. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        [self getAllProperty:[MPVolumeView class]];
        [self getAllFunction:[MPVolumeView class]];
}

// 获取私有属性
- (void)getAllProperty:(Class)class {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    for (int index = 0; index < count; ++index) {
        // 声明属性
        objc_property_t property = properties[index];
        
        // 指针数组. 通过property_getName获取属性的名称
        const char *cName = property_getName(property);
        
        NSString *name = [NSString stringWithUTF8String:cName];
        NSLog(@"name -----> %@", name);
    }
    
}

// 获取私有方法
- (void)getAllFunction:(Class)class {
    
    unsigned int count;
    Method *methods = class_copyMethodList(class, &count);
    
    for (int index = 0; index < count; ++index) {
        Method method = methods[index];
        
        // 这步完了之后, 可以获取到方法的地址
        SEL selector = method_getName(method);
        
        NSString *name = NSStringFromSelector(selector);
        const char *type = method_getTypeEncoding(method);
        NSLog(@"fun-----%@,  type-----> %s",name,type);
    }
}

@end
