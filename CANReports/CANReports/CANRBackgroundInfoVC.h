//
//  CANRBackgroundInfoVC.h
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "XLFormViewController.h"
@class CANRIncident;

@interface CANRBackgroundInfoVC : XLFormViewController


@property (strong, nonatomic) CANRIncident *data;
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;


@end
