//
//  ViewController.m
//  BLRequestDemo
//
//  Created by Bain on 2017/9/14.
//  Copyright © 2017年 BainJ. All rights reserved.
//

#import "ViewController.h"
#import "BLTestApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BLTestApi *api = [[BLTestApi alloc] init];
    [api start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
