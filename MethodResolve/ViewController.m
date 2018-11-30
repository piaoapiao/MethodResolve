//
//  ViewController.m
//  MethodResolve
//
//  Created by guodong on 2018/11/30.
//  Copyright © 2018年 Maizi. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "ForwordObject.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
     [self testCall];
//    [self  performSelector:@selector(xxx) withObject:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)testCall
{
    NSLog(@"testCall");
}


//-(BOOL)respondsToSelector:(SEL)aSelector
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if(sel == @selector(xxx2))
    {
        IMP imp = class_getMethodImplementation(self, @selector(run));
        class_addMethod([self class], sel, imp, "v@:");
        return YES;
    }
    return NO;
}


-(void)run{
    NSLog(@"----run---");
}

//-(id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if(aSelector == @selector(xxx3))
//    {
//        return [ForwordObject new];
//
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}
//
//
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if(aSelector == @selector(xxx))
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector: aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL sel = [anInvocation selector];

    ForwordObject *forword = [ForwordObject new];
    
    if([forword respondsToSelector:sel])
    {
        [anInvocation invokeWithTarget:forword];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}

-(void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"can't recognize");
}


@end
