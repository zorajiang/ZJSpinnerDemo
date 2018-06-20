//
//  ViewController.m
//  ZJSpinnerDemo
//
//  Created by zorajiang on 2018/6/20.
//  Copyright © 2018年 zorajiang. All rights reserved.
//

#import "ViewController.h"
#import "ZJSpinner.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // create
    ZJSpinner *spinner = [[ZJSpinner alloc] init];
    spinner.center = self.view.center;
    [self.view addSubview:spinner];
    
    // animating
    [spinner startLoading];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
