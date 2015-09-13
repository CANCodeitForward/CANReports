//
//  CANRBackgroundInfoVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRBackgroundInfoVC.h"
#import "XLForm.h"


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
    [providerSection addFormRow:providerRow];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Name" forKey:@"textField.placeholder"];
    providerRow.value = @"Canucks Autism Network";
    providerRow.required = YES;
    
    
    // FIX THE FORMATTING OF ADDED PHONE NUMBER
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerPhone" rowType:XLFormRowDescriptorTypePhone];
    [providerSection addFormRow:providerRow];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Phone" forKey:@"textField.placeholder"];
    providerRow.value = @"604-685-4049";
    providerRow.required = YES;
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerAddress" rowType:XLFormRowDescriptorTypeText];
    [providerSection addFormRow:providerRow];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Address" forKey:@"textField.placeholder"];
    providerRow.value = @"101-2020 Yukon Street";
    providerRow.required = YES;
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerCityProvince" rowType:XLFormRowDescriptorTypeText];
    [providerSection addFormRow:providerRow];
    [providerRow.cellConfigAtConfigure setObject:@"Provider City Province" forKey:@"textField.placeholder"];
    providerRow.value = @"Vancouver, BC";
    providerRow.required = YES;
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerPostalCode" rowType:XLFormRowDescriptorTypeText];
    [providerSection addFormRow:providerRow];
    [providerRow.cellConfigAtConfigure setObject:@"Provider Postal Code" forKey:@"textField.placeholder"];
    providerRow.value = @"V5Y 3N8";
    providerRow.required = YES;

    
    
    // Incident Location
    XLFormSectionDescriptor *locationSection;
    XLFormRowDescriptor *locationRow;
    
    locationSection = [XLFormSectionDescriptor formSectionWithTitle:@"Incident Location"];
    [backgroundForm addFormSection:locationSection];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentLocation" rowType:XLFormRowDescriptorTypeText];
    [locationSection addFormRow:locationRow];
    [locationRow.cellConfigAtConfigure setObject:@"Location" forKey:@"textField.placeholder"];
    locationRow.required = YES;
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentPhone" rowType:XLFormRowDescriptorTypePhone];
    [locationSection addFormRow:locationRow];
    [locationRow.cellConfigAtConfigure setObject:@"Phone" forKey:@"textField.placeholder"];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentProgram" rowType:XLFormRowDescriptorTypeText];
    [locationSection addFormRow:locationRow];
    [locationRow.cellConfigAtConfigure setObject:@"Program" forKey:@"textField.placeholder"];
    locationRow.required = YES;
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentAddress" rowType:XLFormRowDescriptorTypeText];
    [locationSection addFormRow:locationRow];
    [locationRow.cellConfigAtConfigure setObject:@"Address" forKey:@"textField.placeholder"];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentCityProvince" rowType:XLFormRowDescriptorTypeText];
    [locationSection addFormRow:locationRow];
    [locationRow.cellConfigAtConfigure setObject:@"City, Province" forKey:@"textField.placeholder"];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentPostalCode" rowType:XLFormRowDescriptorTypeText];
    [locationSection addFormRow:locationRow];
    [locationRow.cellConfigAtConfigure setObject:@"Postal Code" forKey:@"textField.placeholder"];
    
    self.form = backgroundForm;
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.dataDictionary = [NSMutableDictionary dictionary];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showPersonsInvolved"]) {
        NSDictionary *providerDictionary = [self makeProviderDictionary];
        NSDictionary *incidentDictionary = [self makeIncidentDictionary];
        
        [self.dataDictionary setObject:providerDictionary forKey:@"provider"];
        [self.dataDictionary setObject:incidentDictionary forKey:@"incident"];
        
        [[segue destinationViewController] setDataDictionary:self.dataDictionary];

    }
}

-(NSMutableDictionary*)makeIncidentDictionary{
    NSMutableDictionary *incident = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    [incident removeObjectsForKeys:@[@"providerAddress", @"providerCityProvince", @"providerName", @"providerPhone", @"providerPostalCode"]];
    return incident;
}


-(NSMutableDictionary*)makeProviderDictionary{
    NSMutableDictionary *provider = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    [provider removeObjectsForKeys:@[@"incidentAddress", @"incidentCityProvince", @"incidentLocation", @"incidentPhone", @"incidentPostalCode", @"incidentProgram"]];
    return provider;
}

@end