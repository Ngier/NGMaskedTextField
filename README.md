# NGMaskedTextField
NGMaskedTextField makes it easy to apply masks on text fields. You can create phone number, date, time and lots of other masks by NGMaskedTextField.

#Installation
You can install NGMaskedTextField in your project by following two methods:

1) Download the source code and copy the NGMaskedTextField class files into your project.

OR

2) Use cocoa pods. Add following line to Podfile.

```
    pod "NGMaskedTextField"
```

#Usage

To use NGMaskedTextField you need to import NGMaskedTextField.h by following code:

```
    import "NGMaskedTextField.h"
```

Now you can set masks and delegates of text fields. Sample usage is like following code:

```    
    //set text fields' masks
    [self.phoneNumberTextField setMaskString:@"(###) ###-####"];
    [self.dateTextField setMaskString:@"##/##/####"];
    [self.hourTextField setMaskString:@"##:##:##"];
    [self.usStateCodeTextField setMaskString:@"??"];
    
    //set delagete of text fileds as 'self'
    [self.phoneNumberTextField setDelegate:self];
    [self.dateTextField setDelegate:self];
    [self.hourTextField setDelegate:self];
    [self.usStateCodeTextField setDelegate:self];
```

And lastly wherever you want to use NGMaskedTextField you should implement below method in order to mask to be applied:
```
    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        if ([textField isKindOfClass:[NGMaskedTextField class]]) {
            return [(NGMaskedTextField *)textField shouldChangeCharactersInRange:range replacementString:string];
        } else {
            return YES;
        }
    }
```






