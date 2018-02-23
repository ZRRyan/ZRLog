//
//  ViewController.m
//  ConsoleDemo
//
//  Created by Ryan on 2017/12/6.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "ViewController.h"
#import "ZRLogHelper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [[ZRLogHelper shareInstance] configLog];
//    [ZRLogHelper shareInstance].cache = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)switchChange:(id)sender {
    [ZRLogHelper shareInstance].cache = YES;
}


- (IBAction)insertLog:(id)sender {
    
    if (self.contentTextField.text == nil || [self.contentTextField.text isEqualToString:@""]) {
        return;
    }
    
    [[ZRLogHelper shareInstance] printWithTitle:self.titleTextField.text content:self.contentTextField.text];
    
}

@end
