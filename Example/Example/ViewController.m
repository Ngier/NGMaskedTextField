//
//  ViewController.m
//  Example
//
//  Created by Berk on 05/02/16.
//  Copyright © 2016 Berk Dilek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set text fields' masks
    [self.phoneNumberTextField setMaskString:@"(###) ###-####"];
    [self.dateTextField setMaskString:@"##/##/####"];
    [self.hourTextField setMaskString:@"##:##:##"];
    [self.dateAndHourTextField setMaskString:@"##/##/## ##:##:##"];
    [self.CVCNumberTextField setMaskString:@"###"];
    [self.expireDateTextField setMaskString:@"##/##"];
    [self.usStateCodeTextField setMaskString:@"??"];
    
    //set delagete of text fileds as 'self'
    [self.phoneNumberTextField setDelegate:self];
    [self.dateTextField setDelegate:self];
    [self.hourTextField setDelegate:self];
    [self.dateAndHourTextField setDelegate:self];
    [self.CVCNumberTextField setDelegate:self];
    [self.expireDateTextField setDelegate:self];
    [self.usStateCodeTextField setDelegate:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isKindOfClass:[NGMaskedTextField class]]) {
        return [(NGMaskedTextField *)textField shouldChangeCharactersInRange:range replacementString:string];
    } else {
        return YES;
    }
}


@end
