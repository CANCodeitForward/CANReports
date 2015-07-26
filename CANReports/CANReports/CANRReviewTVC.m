//
//  CANRReviewTVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-25.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRReviewTVC.h"
#import "CANRIncident.h"
#import "CANRPersonInvolved.h"

@interface CANRReviewTVC ()

@property (strong, nonatomic) CANRIncident *data;
@property

@end

@implementation CANRReviewTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendJSONWithData:(UserData *)data {
    NSDictionary *userDictionary = @{
                                     @"provider": @{
                                             @"providerName": data.providerName,
                                             @"providerPhone": data.providerPhone,
                                             @"providerAddress": data.providerAddress,
                                             @"providerCityProvince": data.providerCityProvince,
                                             @"providerPostalCode": data.providerPostalCode
                                             }
                                     @"incident": @{
                                             @"incidentLocation": data.incidentLocation,
                                             @"incidentPhone": data.incidentPhone,
                                             @"incidentProgram": data.incidentProgram,
                                             @"incidentAddress": data.incidentAddress
                                             @"incidentCityProvince": data.incidentCityProvince,
                                             @"incidentPostalCode": data.incidentPostalCode
                                             }
                                     // must be dynamic based on number of people, TO DO!!!
                                     @"persons": @{
                                             @"person1": @{
                                                     @"firstName": data.firstName,
                                                     @"lastName": data.lastName,
                                                     @"address": data.address,
                                                     @"phoneNumber": data.phoneNumber
                                                     }
                                             };
                                     @"typeofIncident": @{
                                             @"isPhysicalAbuse": data.isPhysicalAbuse,
                                             @"isSexualAbuse": data.isSexualAbuse,
                                             @"isEmotionalAbuse": data.isEmotionalAbuse,
                                             @"isNeglect": data.isNeglect,
                                             @"isFinancialAbuse": data.isFinancialAbuse,
                                             @"isUnexpectedIllness": data.isUnexpectedIllness,
                                             @"isDiseaseOutbreak": data.isDiseaseOutbreak,
                                             @"isDeath": data.isDeath,
                                             @"isFall": data.isFall,
                                             @"isMotorVehicleInjury": data.isMotorVehicleInjury,
                                             @"isOtherInjury": data.isOtherInjury,
                                             @"isPoisoning": data.isPoisoning,
                                             @"isAgressiveUnusualBehaviour": data.isAgressiveUnusualBehaviour,
                                             @"isMissingPerson": data.isMissingPerson,
                                             @"isMedicationError": data.isMedicationError
                                             }
                                     @"incidentDetails": @{
                                             @"dateAndTimeOfIncident": data.dateAndTimeOfIncident,
                                             @"incidentDescription": data.incidentDescription,
                                             @"firstAidGiven": data.firstAidGiven,
                                             @"firstAidGivenBy": data.firstAidGivenBy,
                                             @"visitedClinic": data.visitedClinic,
                                             @"clinicDoctorName": data.clinicDoctorName,
                                             @"visitedHospital": data.visitedHospital,
                                             @"hospitalDoctorName": data.hospitalDoctorName,
                                             }
                                     @"familyNotification": @{
                                             @"isFamilyNotified": data.isFamilyNotified,
                                             @"dateAndTimeOfNotification": data.dateAndTimeOfNotification,
                                             @"familyMemberNotified": data.familyMemberNotified,
                                             @"familyMemberRelationship": data.familyMemberRelationship,
                                             @"familyMemberPhone": data.familyMemberPhone
                                             }
                                     @"administration": @{
                                             @"reporterName": data.reporterName,
                                             @"reporterPosition": data.reporterPosition,
                                             @"witnessName": data.witnessName,
                                             @"witnessPosition": data.witnessPosition,
                                             @"supervisorName": data.supervisorName
                                             }
    
    NSError *jsonSendError = nil;
    NSData *jsonSend = [NSJSONSerialization dataWithJSONObject:userDictionary options:0 error:&jsonSendError];
    
    // Using Socket.IO; Replace with HTTP POST if using REST.
    [socket emit:@"UserDataStore" json:jsonSend];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
