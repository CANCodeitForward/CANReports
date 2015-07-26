//
//  CANRPersonInvolved.h
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-25.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CANRPersonInvolved : NSObject


// Section 2: Person(s) Involved
@property (strong, nonatomic) NSString *personInvolved;
@property (strong, nonatomic) NSDate *personBirthdate;
@property (assign, nonatomic) BOOL isMale;


@end
