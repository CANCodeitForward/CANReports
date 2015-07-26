//
//  CANRNotificationVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRNotificationVC.h"
#import "XLForm.h"
#import "CANRIncident.h"

@interface CANRNotificationVC ()

@end

@implementation CANRNotificationVC

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self){
        [self initializeForm];
    }
    return self;
}

-(void)initializeForm
{
    XLFormDescriptor *notificationForm = [XLFormDescriptor formDescriptorWithTitle:@"Notification"];
    
    //    backgroundForm.assignFirstResponderOnShow = YES;
    
    // Was Family Notified
    XLFormSectionDescriptor *notificationSection;
    XLFormRowDescriptor *notificationRow;
    
    notificationSection = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [notificationForm addFormSection:notificationSection];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyNotified" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Family Notified"];
    notificationRow.value = @0;
    [notificationSection addFormRow:notificationRow];
    
    
    // Family Member Notified
    notificationSection = [XLFormSectionDescriptor formSectionWithTitle:@"Family Member Notified"];
    notificationSection.hidden = [NSString stringWithFormat:@"$%@==0", @"familyNotified"];
    [notificationForm addFormSection:notificationSection];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"dateAndTimeOfNotification" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"When?"];
    notificationRow.value = [NSDate new];
    [notificationSection addFormRow:notificationRow];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyMemberNotified" rowType:XLFormRowDescriptorTypeText];
    [notificationRow.cellConfigAtConfigure setObject:@"Family Member Notified" forKey:@"textField.placeholder"];
    [notificationSection addFormRow:notificationRow];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyMemberRelationship" rowType:XLFormRowDescriptorTypeText];
    [notificationRow.cellConfigAtConfigure setObject:@"Relationship" forKey:@"textField.placeholder"];
    [notificationSection addFormRow:notificationRow];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyMemberPhone" rowType:XLFormRowDescriptorTypePhone];
    [notificationRow.cellConfigAtConfigure setObject:@"Phone Number" forKey:@"textField.placeholder"];
    [notificationSection addFormRow:notificationRow];
    
    
    
    // Reporter
    XLFormSectionDescriptor *reporterSection;
    XLFormRowDescriptor *reporterRow;
    
    reporterSection = [XLFormSectionDescriptor formSectionWithTitle:@"Reporter"];
    [notificationForm addFormSection:reporterSection];
    
    reporterRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"reporterName" rowType:XLFormRowDescriptorTypeText];
    [reporterRow.cellConfigAtConfigure setObject:@"Reporter" forKey:@"textField.placeholder"];
    [reporterSection addFormRow:reporterRow];
    
    reporterRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"reporterPosition" rowType:XLFormRowDescriptorTypeText];
    [reporterRow.cellConfigAtConfigure setObject:@"Position" forKey:@"textField.placeholder"];
    [reporterSection addFormRow:reporterRow];
    
    
    
    // Witness
    XLFormSectionDescriptor *witessSection;
    XLFormRowDescriptor *witnessRow;
    
    witessSection = [XLFormSectionDescriptor formSectionWithTitle:@"Witness"];
    [notificationForm addFormSection:witessSection];
    
    witnessRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"witnessName" rowType:XLFormRowDescriptorTypeText];
    [witnessRow.cellConfigAtConfigure setObject:@"Witness" forKey:@"textField.placeholder"];
    [witessSection addFormRow:witnessRow];
    
    witnessRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"witnessPosition" rowType:XLFormRowDescriptorTypeText];
    [witnessRow.cellConfigAtConfigure setObject:@"Position" forKey:@"textField.placeholder"];
    [witessSection addFormRow:witnessRow];
    
    
    
    // Reporter
    XLFormSectionDescriptor *supervisorSection;
    XLFormRowDescriptor *supervisorRow;
    
    supervisorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Supervisor"];
    [notificationForm addFormSection:supervisorSection];
    
    supervisorRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"supervisorName" rowType:XLFormRowDescriptorTypeText];
    [supervisorRow.cellConfigAtConfigure setObject:@"Supervisor" forKey:@"textField.placeholder"];
    [supervisorSection addFormRow:supervisorRow];
    
    supervisorRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"supervisorPosition" rowType:XLFormRowDescriptorTypeText];
    [supervisorRow.cellConfigAtConfigure setObject:@"Position" forKey:@"textField.placeholder"];
    [supervisorSection addFormRow:supervisorRow];
    
    
    
    self.form = notificationForm;
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.data = [[CANRIncident alloc]init];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
}


-(void)savePressed:(UIBarButtonItem * __unused)button
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 80000
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil)
                                                      message:@"No errors found"
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                            otherButtonTitles:nil];
    [message show];
#else
    if ([UIAlertController class]){
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Valid Form", nil)
                                                                                  message:@"No errors found"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil)
                                                          message:@"No errors found"
                                                         delegate:nil
                                                cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                otherButtonTitles:nil];
        [message show];
    }
#endif
}

@end
