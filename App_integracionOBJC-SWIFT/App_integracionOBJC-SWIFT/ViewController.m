//
//  ViewController.m
//  App_integracionOBJC-SWIFT
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Esto es un alert" message:@"Alerta!!!" preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL]];
    
    [self.navigationController presentViewController:alert animated:YES completion:NULL];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)muestraSaludo:(id)sender {
    
    self.mySaludoLBL.text = @"Hola en OBJ-C de iOS";
}
@end
