//
//  ViewController.m
//  RunloopAndThread
//
//  Created by 张星宇 on 16/7/24.
//  Copyright © 2016年 bestswifter. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+DeallocBlock.h"

@interface ViewController ()

@property (strong, nonatomic) NSPort *emptyPort;
@property (strong, nonatomic) NSThread *thread;
@property (assign, nonatomic) BOOL shouldKeepRunning;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self memoryTest];
    NSLog(@"test");
//    [self runloopTest];
}

#pragma --mark 内存占用测试
- (void)memoryTest {
    for (int i = 0; i < 100000; ++i) {
        //总结：test At: xcode8,ios 9.3.4
        //1,当用CFRunLoopRun(),然后调用CFRunLoopStop，此方法是后果会输出current thread，thread dealloc，current thread，thread dealloc ...所以不会用内存问题
        //2,当用 [runLoop run];,然后调用CFRunLoopStop,此方法会current thread，current thread，... 最后输出[NSThread start]: Thread creation failed with error 35.然后app卡住，然后app crash. 内存不会暴增。但是线程无法销毁
        //3,当用 [runLoop runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];,然后调用CFRunLoopStop,此方法会。[ViewController performSelector:onThread:withObject:waitUntilDone:modes:]: target thread exited while waiting for the perform' crash。是因为 [runLoop runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]]; 无法阻塞线程，所以线程很快执行完run 方法。然后线程exit，导致奔溃（在一个退出的线程，当然这个时候线程没有释放，执行方法奔溃）
        
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        [thread runAtDealloc:^{
            NSLog(@"thread dealloc");
        }];
        [thread start];
        [self performSelector:@selector(stopThread) onThread:thread withObject:nil waitUntilDone:YES];
    }
    NSLog(@"test over");
}

- (void)stopThread {
    CFRunLoopStop(CFRunLoopGetCurrent());
//    [[NSRunLoop currentRunLoop] removePort:self.emptyPort forMode:NSDefaultRunLoopMode];
    NSThread *thread = [NSThread currentThread];
    [thread cancel];
}

- (void)run {
    @autoreleasepool {
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        if (!self.emptyPort) {
            self.emptyPort = [NSMachPort port];
        }
        [runLoop addPort:self.emptyPort forMode:NSDefaultRunLoopMode];
        // 下面这两种写法都不可取
//        [runLoop run];
        [runLoop runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
//        CFRunLoopRun();
        NSLog(@"run over");
    }
}

# pragma --mark runloop 启动与退出测试
- (void)runloopTest {
    //  绘制按钮，点击按钮后关闭 runloop
    UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [stopButton setTitle:@"Stop Timer" forState:UIControlStateNormal];
    [stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:stopButton];
    [stopButton addTarget:self action:@selector(stopButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.shouldKeepRunning = YES;
    
    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(singleThread) object:nil];
    [self.thread start];
    [self performSelector:@selector(printSomething) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)singleThread {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        if (!self.emptyPort) {
            self.emptyPort = [NSMachPort port];
        }
        [runLoop addPort:self.emptyPort forMode:NSDefaultRunLoopMode];
        CFRunLoopRun();
//        while (_shouldKeepRunning && [runLoop runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]]);
    }
}

- (void)printSomething {
    NSLog(@"current thread = %@", [NSThread currentThread]);
    [self performSelector:@selector(printSomething) withObject:nil afterDelay:1];
}

#pragma --mark 点击按钮退出
- (void)stopButtonDidClicked:(id)sender {
    [self performSelector:@selector(stopRunloop) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)stopRunloop {
    // self.shouldKeepRunning = NO;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
