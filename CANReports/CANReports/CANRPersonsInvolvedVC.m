//
//  CANRPersonsInvolvedVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRPersonsInvolvedVC.h"
#import "XLForm.h"

@interface CANRPersonsInvolvedVC ()

@end

@implementation CANRPersonsInvolvedVC

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
    XLFormDescriptor *personsForm = [XLFormDescriptor formDescriptorWithTitle:@"Person(s) Involved"];
    
//    personsForm.assignFirstResponderOnShow = YES;
    
    // Person(s) Involved
    XLFormSectionDescriptor *personsSection;
    XLFormRowDescriptor *personRow;
    
    personsSection = [XLFormSectionDescriptor formSectionWithTitle:@"Person"];
    [personsForm addFormSection:personsSection];
    
    
    personRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"personInvolved" rowType:XLFormRowDescriptorTypeText];
    [personsSection addFormRow:personRow];
    [personRow.cellConfigAtConfigure setObject:@"Name of Person" forKey:@"textField.placeholder"];
    personRow.required = YES;
    
    
    personRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"personBirthdate" rowType:XLFormRowDescriptorTypeDateInline title:@"Birthdate"];
    [personsSection addFormRow:personRow];
    personRow.value = [NSDate new];
    
    // coming up in dictionary as pointer address. FIX THIS
    personRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"personGender" rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"Gender"];
    [personsSection addFormRow:personRow];
    personRow.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@("Male") displayText:@"Male"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@("Female") displayText:@"Female"],
                            ];
    personRow.value = [XLFormOptionsObject formOptionsObjectWithValue:@("") displayText:@""];
    
    
    
    self.form = personsForm;
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showIncidentDetails"]) {
        NSDictionary *personsDictionary = [self makePersonsDictionary];
 
        [self.dataDictionary setObject:personsDictionary forKey:@"persons"];
        
        [[segue destinationViewController] setDataDictionary:self.dataDictionary];
        
    }
}


-(NSMutableDictionary*)makePersonsDictionary{
    NSMutableDictionary *persons = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    return persons;
}




@end