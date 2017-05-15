//
//  UserInputViewController.m
//  arementalkingtoomuch
//
//  Created by Jean-Paul Gorman on 09/05/2017.
//  Copyright © 2017 Jean-Paul Gorman. All rights reserved.
//

#import "UserInputViewController.h"
#import "CustomTextField.h"
#import "CustomButton.h"
#import "ViewController.h"

@interface UserInputViewController ()
@property (weak, nonatomic) IBOutlet CustomTextField *PersonA;
@property (weak, nonatomic) IBOutlet CustomTextField *PersonB;
@property (weak, nonatomic) IBOutlet CustomButton *submitButton;

@end

@implementation UserInputViewController



#pragma mark - initialisation from sqgue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"StartConversation"]) {
        if([segue.destinationViewController isKindOfClass:[ViewController class]]) {
            ViewController *vc = (ViewController *)segue.destinationViewController;
            vc.personA = self.PersonA.text;
            vc.personB = self.PersonB.text;
        }
    }
}

- (void)textFieldDidBeginEditing:(CustomTextField *)textField {
    NSLog(@"Text field did begin editing");
}
- (void)textFieldDidEndEditing:(CustomTextField *)textField {
    NSLog(@"Text field ended editing");
}

-(BOOL)textFieldShouldReturn:(CustomTextField *)textField
{
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Confirmation"
                                 message:self.PersonA.text
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:nil];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:nil];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    return YES;
}

- (IBAction)submit:(id)sender {
    [self performSegueWithIdentifier:@"StartConversation" sender:sender];
}

- (void)viewDidLoad {
    [self setUp];
    [super viewDidLoad];
}

- (void)setUp {
    self.PersonA.label = @"Me?";
    self.PersonB.label = @"Someone else?";
    self.submitButton.label = @"Start";
    // sets the delegate to the current class
    self.PersonA.delegate = self;
    self.PersonB.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
