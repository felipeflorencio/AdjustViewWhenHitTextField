# ${1:Project Name}

# Description
Easy description of how adjust views that has UITextField and when keyboard show up text field stayed behind keyboard.

#Why?
This tutorial its just a simple example that how we make view scroll up and back to original state after keyboard show and the tapped UITextField stayed behind keyboard.

That could be applied for any object that of kind UIView, for example: UILabel, UIButton.

#Tutorial

Download project and see how we created or view, most important to know is, the right way in this case is use UIScrollView, that because if we handle with our UIView some weird situations, like a black view behind happens.   

#Code
First at viewDidLoad method insert this notifications

```objective-c
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
```

Not we will create methods that will be called when keyboard will show up and dismiss

```objective-c
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
```

Now you will see that we are getting our field size, and for that i created a helper method that will "save" which UITextField was select for we get size and other informations.

First create a property in our interface:
```objective-c
@property (nonatomic, strong) UITextField *selectedField;
```

Now create the method that will receive UITextfield notification, we already attached notification at viewDidLoad:
```objective-c


- (void)userTappedOnField:(NSNotification*)txtSelected{

    if ([txtSelected.object isKindOfClass:UITextField.class]){
        _selectedField = txtSelected.object;
    }

}

```

Now its done, use project to see finished, has one or other helper, but with just this code everything was fine.

#Tip

If you don't want handle all this thinks just use a UITableView, when your view is inside UITableView, the table view will handle this scroll situation without any other implementation.
