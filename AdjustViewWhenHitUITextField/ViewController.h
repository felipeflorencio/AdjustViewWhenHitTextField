//
//  ViewController.h
//  AdjustViewWhenHitUITextField
//
//  Created by Felipe Florencio Garcia on 1/10/16.
//  Copyright © 2016 Felipe Florencio Garcia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtFirstField;
@property (strong, nonatomic) IBOutlet UITextField *txtSecondTextField;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *viewInsideScroll;

@end

