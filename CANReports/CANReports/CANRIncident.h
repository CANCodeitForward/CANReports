//
//  CANRIncident.h
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-25.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CANRIncident : NSObject


// Section 1: Background Information
@property (strong, nonatomic) NSString *providerName;
@property (strong, nonatomic) NSString *providerPhone;
@property (strong, nonatomic) NSString *providerAddress;
@property (strong, nonatomic) NSString *providerCityProvince;
@property (strong, nonatomic) NSString *providerPostalCode;

@property (strong, nonatomic) NSString *incidentLocation;
@property (strong, nonatomic) NSString *incidentPhone;
@property (strong, nonatomic) NSString *incidentProgram;
@property (strong, nonatomic) NSString *incidentAddress;
@property (strong, nonatomic) NSString *incidentCityProvince;
@property (strong, nonatomic) NSString *incidentPostal;


// Section 2: Person(s) Involved, please see CANRPersonInvolved class


// Section 3: Type of Incident
@property (assign, nonatomic) BOOL isPhysicalAbuse;
@property (assign, nonatomic) BOOL isSexualAbuse;
@property (assign, nonatomic) BOOL isEmotionalAbuse;
@property (assign, nonatomic) BOOL isNeglect;
@property (assign, nonatomic) BOOL isFinancialAbuse;
@property (assign, nonatomic) BOOL isUnexpectedIllness;
@property (assign, nonatomic) BOOL isDiseaseOutbreak;
@property (assign, nonatomic) BOOL isDeath;
@property (assign, nonatomic) BOOL isFall;
@property (assign, nonatomic) BOOL isMotorVehicleInjury;
@property (assign, nonatomic) BOOL isOtherInjury;
@property (assign, nonatomic) BOOL isPoisoning;
@property (assign, nonatomic) BOOL isAgressiveUnusualBehaviour;
@property (assign, nonatomic) BOOL isMissingPerson;
@property (assign, nonatomic) BOOL isMedicationError;



// Section 4: Incident Details
@property (strong, nonatomic) NSDate *dateAndTimeOfIncident;
@property (strong, nonatomic) NSString *incidentDescription;
@property (assign, nonatomic) BOOL firstAidGiven;
@property (strong, nonatomic) NSString *firstAidGivenBy;
@property (assign, nonatomic) BOOL visitedClinic;
@property (strong, nonatomic) NSString *clinicDoctorName;
@property (assign, nonatomic) BOOL visitedHospital;
@property (strong, nonatomic) NSString *hospitalDoctorName;



// Section 5: Notification
@property (assign, nonatomic) BOOL isFamilyNotified;
@property (strong, nonatomic) NSDate *dateAndTimeOfNotification;
@property (strong, nonatomic) NSString *familyMemberNotified;
@property (strong, nonatomic) NSString *familyMemberRelationship;
@property (strong, nonatomic) NSString *familyMemberPhone;

@property (strong, nonatomic) NSString *reporterName;
@property (strong, nonatomic) NSString *reporterPosition;
@property (strong, nonatomic) NSString *witnessName;
@property (strong, nonatomic) NSString *witnessPosition;
@property (strong, nonatomic) NSString *supervisorName;
@property (strong, nonatomic) NSString *supervisorPosition;




@end
