//
//  ViewController.m
//  OtherLinkerFlag
//
//  Created by 张星宇 on 2017/1/7.
//  Copyright © 2017年 bestswifter. All rights reserved.
//

#import "ViewController.h"
#import "BSStaticLibraryOne.h"
#import "BSStaticLibraryOne+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[BSStaticLibraryOne alloc] init] sayOtherThing];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
