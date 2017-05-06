//
//  DatosModel.m
//  App_integracionOBJC-SWIFT
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

#import "DatosModel.h"

@implementation DatosModel

#pragma mark - Constructor designado
+ (id)datosModelWithFirstName: (NSString *)pFirstName lastName: (NSString *)pLastName alias: (NSString *)pAlias{
    return [[self alloc]initWithFirstName:pFirstName lastName:pLastName alias:pAlias];
}

#pragma mark - Inicializador designado
- (id)initWithFirstName: (NSString *)pFirstName lastName: (NSString *)pLastName alias: (NSString *)pAlias{
    if ([super init]) {
        self.firstName = pFirstName;
        self.lastName = pLastName;
        self.alias = pAlias;
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Mi nombre es: Name=%@ Author=%@ y mi alias =%@", self.firstName, self.lastName, self.alias];
}

@end
