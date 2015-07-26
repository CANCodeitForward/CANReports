//
//  AppDelegate.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-25.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UITableViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:126.0/255.0 blue:58.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [[UISwitch appearance] setOnTintColor:[UIColor colorWithRed:0.0/255.0 green:126.0/255.0 blue:58.0/255.0 alpha:1.0]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}

@end
