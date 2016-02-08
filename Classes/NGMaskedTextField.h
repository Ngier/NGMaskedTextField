//
//  NGMaskedTextField.h
//  Example
//
//  Created by Berk on 05/02/16.
//  Copyright © 2016 Berk Dilek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGMaskedTextField : UITextField

@property (nonatomic, strong) NSString *inputString;
@property (nonatomic, strong) NSString *maskString;
@property (nonatomic, strong) NSString *defaultCharacterMask;
@property (nonatomic, strong) NSString *defaultNumberMask;
@property (nonatomic, strong) NSString *defaultFill;

- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end


