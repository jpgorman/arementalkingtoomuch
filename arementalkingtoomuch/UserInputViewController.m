//
//  UserInputViewController.m
//  arementalkingtoomuch
//
//  Created by Jean-Paul Gorman on 09/05/2017.
//  Copyright © 2017 Jean-Paul Gorman. All rights reserved.
//

#import "UserInputViewController.h"
#import "ViewController.h"

@interface UserInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textInput;

@end

@implementation UserInputViewController



#pragma mark - initialisation from sqgue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"StartConversation"]) {
        if([segue.destinationViewController isKindOfClass:[ViewController class]]) {
            ViewController *vc = (ViewController *)segue.destinationViewController;
            vc.topic = self.textInput.text;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Confirmation"
                                 message:self.textInput.text
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
    [super viewDidLoad];
    self.textInput.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
