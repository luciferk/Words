//
//  PopViewController.m
//  Words
//
//  Created by whq on 2019/4/30.
//  Copyright © 2019 whq. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)exit:(id)sender {
     [[NSApplication sharedApplication] terminate:self];
}

@end
