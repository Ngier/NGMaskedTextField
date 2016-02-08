//
//  NGMaskedTextField.m
//  Example
//
//  Created by Berk on 05/02/16.
//  Copyright © 2016 Berk Dilek. All rights reserved.
//

#import "NGMaskedTextField.h"

NSString *kMaskedTextFieldDefaultCharacterMask = @"?";
NSString *kMaskedTextFieldDefaultNumberMask = @"#";
NSString *kMaskedTextFieldDefaultFill = @"";

@interface NGMaskedTextField ()

@end

@implementation NGMaskedTextField

@synthesize inputString = _inputString;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefaultCharacterMask:kMaskedTextFieldDefaultCharacterMask];
        [self setDefaultNumberMask:kMaskedTextFieldDefaultNumberMask];
        [self setDefaultFill:kMaskedTextFieldDefaultFill];
        
        [self addTarget:self action:@selector(textFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultCharacterMask:kMaskedTextFieldDefaultCharacterMask];
        [self setDefaultNumberMask:kMaskedTextFieldDefaultNumberMask];
        [self setDefaultFill:kMaskedTextFieldDefaultFill];
        
        [self addTarget:self action:@selector(textFieldValueDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}


- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.maskString == nil) {
        return YES;
    }
    
    if (range.length > 0) {
        if (self.inputString.length >= range.length) {
            // removing characters with length: range.length
            self.inputString = [self.inputString substringWithRange:NSMakeRange(0, self.inputString.length - range.length)];
        } else {
            // input string is not long enough to delete
            return NO;
        }
    }
    
    if (string.length > 1) {
        // inserting more than 1 character at once
        
        NSMutableArray *multipleCharString = [NSMutableArray array];
        for (int i = 0; i<string.length; i++) {
            [multipleCharString addObject:[NSString stringWithFormat:@"%c",[string characterAtIndex:i]]];
        }

        
        for (int i = 0; i < multipleCharString.count; i++) {
            if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(i, 0) replacementString:[multipleCharString objectAtIndex:i]];
            }
        }
    } else if (string.length > 0) {
        // adding characters with length: string.length
        if (self.inputString.length + string.length <= [self desiredInputLength]) {
            NSInteger chartype = [self desiredInputCharacterTypeForOffset:0];
            NSCharacterSet *desiredCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"abcçdefgğhıijklmnoöprsştuüvyzqwxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWX0123456789"];
            if (chartype == 1) {
                desiredCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"abcçdefgğhıijklmnoöprsştuüvyzqwxABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZQWX"];
            } else if (chartype == 2) {
                desiredCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            }
            
            if ([desiredCharacterSet isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:[string substringToIndex:1]]]) {
                self.inputString = [NSString stringWithFormat:@"%@%@", self.inputString, string];
            } else {
                // character is not suitable for mask
                return NO;
            }
        } else {
            // input is too long to add
            return NO;
        }
    }
    return YES;
}

- (void)textFieldValueDidChange {
    if (self.maskString != nil) {
        [self setText:[self executeMaskOnInput]];
    }
}

- (NSString *)inputString {
    if (_inputString == nil) {
        _inputString = @"";
    }
    return _inputString;
}

- (void)setInputString:(NSString *)inputString {
    _inputString = inputString;
    if (self.inputString.length == 0) {
        [self setText:@""];
    }
}

- (void)setMaskString:(NSString *)maskString {
    _maskString = maskString;
    [self setText:[self executeMaskOnInput]];
    if (self.inputString.length == 0) {
        [self setText:@""];
    }
}

- (NSString *)executeMaskOnInput {
    NSMutableString *mutableString = [NSMutableString string];
    NSInteger inputIndex = 0;
    for (int i = 0; i < self.maskString.length; i++) {
        if ([self.maskString characterAtIndex:i] == [self.defaultCharacterMask characterAtIndex:0] || [self.maskString characterAtIndex:i] == [self.defaultNumberMask characterAtIndex:0]) {
            if (inputIndex < self.inputString.length) {
                [mutableString appendString:[NSString stringWithFormat:@"%c", [self.inputString characterAtIndex:inputIndex]]];
                inputIndex++;
            } else {
                [mutableString appendString:self.defaultFill];
            }
        } else {
            [mutableString appendString:[NSString stringWithFormat:@"%c", [self.maskString characterAtIndex:i]]];
        }
    }
    return mutableString;
}

- (NSInteger)desiredInputLength {
    int length = 0;
    for (int i = 0; i < self.maskString.length; i++) {
        if ([self.maskString characterAtIndex:i] == [self.defaultCharacterMask characterAtIndex:0] ||
            [self.maskString characterAtIndex:i] == [self.defaultNumberMask characterAtIndex:0]) {
            length++;
        }
    }
    return length;
}

- (NSInteger)desiredInputCharacterTypeForOffset:(NSInteger)offset {
    NSMutableString *maskString = [NSMutableString stringWithString:self.maskString];
    
    for (int i = 0; i < self.inputString.length; i++) {
        for (int j = 0; j < maskString.length; j++) {
            if ([maskString characterAtIndex:j] == [self.defaultCharacterMask characterAtIndex:0] ||
                [maskString characterAtIndex:j] == [self.defaultNumberMask characterAtIndex:0]) {
                [maskString replaceCharactersInRange:NSMakeRange(j, 1) withString:self.defaultFill];
                break;
            }
        }
    }
    
    for (int i = 0; i < maskString.length; i++) {
        if ([maskString characterAtIndex:i] == [self.defaultCharacterMask characterAtIndex:0]) {
            return 1;
        } else if ([maskString characterAtIndex:i] == [self.defaultNumberMask characterAtIndex:0]) {
            return 2;
        }
    }
    
    return -1;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    if (self.maskString == nil) {
        return [super caretRectForPosition:position];
    } else {
        return [super caretRectForPosition:position];

    }
}

@end
