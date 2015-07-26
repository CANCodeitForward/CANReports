//
//  CANRBackgroundInfoVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRBackgroundInfoVC.h"
#import "XLForm.h"
#import "CANRIncident.h"


@implementation CANRBackgroundInfoVC

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
    XLFormDescriptor *backgroundForm = [XLFormDescriptor formDescriptorWithTitle:@"Background Information"];

//    backgroundForm.assignFirstResponderOnShow = YES;
    
    
    // Provider (with pre-populated, editable data)
    XLFormSectionDescriptor *providerSection;
    XLFormRowDescriptor *providerRow;
    
    providerSection = [XLFormSectionDescriptor formSectionWithTitle:@"*Do NOT talk to the media at any time"];
    [backgroundForm addFormSection:providerSection];
    
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerName" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Name" forKey:@"textField.placeholder"];
    providerRow.value = @"Canucks Autism Network";
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    
    // FIX THE FORMATTING OF ADDED PHONE NUMBER
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerPhone" rowType:XLFormRowDescriptorTypePhone];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Phone" forKey:@"textField.placeholder"];
    providerRow.value = @"604-685-4049";
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerAddress" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Address" forKey:@"textField.placeholder"];
    providerRow.value = @"101-2020 Yukon Street";
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerCityProvince" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"Provider City Province" forKey:@"textField.placeholder"];
    providerRow.value = @"Vancouver, BC";
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerPostalCode" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Postal Code" forKey:@"textField.placeholder"];
    providerRow.value = @"V5Y 3N8";
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];

    
    
    // Incident Location
    XLFormSectionDescriptor *locationSection;
    XLFormRowDescriptor *locationRow;
    
    locationSection = [XLFormSectionDescriptor formSectionWithTitle:@"Incident Location"];
    [backgroundForm addFormSection:locationSection];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentLocation" rowType:XLFormRowDescriptorTypeText];
    [locationRow.cellConfigAtConfigure setObject:@"Location" forKey:@"textField.placeholder"];
    locationRow.required = YES;
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentPhone" rowType:XLFormRowDescriptorTypePhone];
    [locationRow.cellConfigAtConfigure setObject:@"Phone" forKey:@"textField.placeholder"];
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentProgram" rowType:XLFormRowDescriptorTypeText];
    [locationRow.cellConfigAtConfigure setObject:@"Program" forKey:@"textField.placeholder"];
    locationRow.required = YES;
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentAddress" rowType:XLFormRowDescriptorTypeText];
    [locationRow.cellConfigAtConfigure setObject:@"Address" forKey:@"textField.placeholder"];
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentCityProvince" rowType:XLFormRowDescriptorTypeText];
    [locationRow.cellConfigAtConfigure setObject:@"City, Province" forKey:@"textField.placeholder"];
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentPostalCode" rowType:XLFormRowDescriptorTypeText];
    [locationRow.cellConfigAtConfigure setObject:@"Postal Code" forKey:@"textField.placeholder"];
    [locationSection addFormRow:locationRow];
    
    self.form = backgroundForm;
    
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