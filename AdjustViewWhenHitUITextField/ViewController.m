//
//  ViewController.m
//  AdjustViewWhenHitUITextField
//
//  Created by Felipe Florencio Garcia on 1/10/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *selectedField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set observer for receive keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userTappedOnField:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.viewInsideScroll addGestureRecognizer:tapGesture];
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hideKeyBoard{
    [self.view endEditing:YES];
}

- (void)userTappedOnField:(NSNotification*)txtSelected{

    if ([txtSelected.object isKindOfClass:UITextField.class]){
        _selectedField = txtSelected.object;
    }
    
}

// View readjust actions
- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint txtFieldView = _selectedField.frame.origin;
    
    CGFloat txtFieldViewHeight = _selectedField.frame.size.height;
    
    CGRect visibleRect = self.viewInsideScroll.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, txtFieldView)){
        
        CGPoint scrollPoint = CGPointMake(0.0, txtFieldView.y - visibleRect.size.height + (txtFieldViewHeight * 1.5));
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}

@end
