//
//  NGMaskedTextField.h
//  NGMaskedTextField
//
//  Created by Faruk Kuşcan on 07/10/15.
//  Copyright © 2015 ngier. All rights reserved.
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