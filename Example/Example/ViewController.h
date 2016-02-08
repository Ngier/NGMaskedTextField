//
//  ViewController.h
//  Example
//
//  Created by Berk on 05/02/16.
//  Copyright © 2016 Berk Dilek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGMaskedTextField.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet NGMaskedTextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet NGMaskedTextField *dateTextField;
@property (strong, nonatomic) IBOutlet NGMaskedTextField *hourTextField;
@property (strong, nonatomic) IBOutlet NGMaskedTextField *dateAndHourTextField;
@property (strong, nonatomic) IBOutlet NGMaskedTextField *CVCNumberTextField;
@property (strong, nonatomic) IBOutlet NGMaskedTextField *expireDateTextField;
@property (strong, nonatomic) IBOutlet NGMaskedTextField *usStateCodeTextField;


@end

