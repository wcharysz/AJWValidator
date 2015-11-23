//
//  ValidationRuleCountry.swift
//  Validator
//
//  Created by Wojciech Charysz on 23.11.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

import Foundation

public struct ValidationRuleCountry: ValidationRule {
    
    public typealias InputType = String
    
    public var failureError: ValidationErrorType
    
    public init(failureError: ValidationErrorType) {
        self.failureError = failureError
    }
    
    public func validateInput(input: InputType?) -> Bool {
        
        if let countryName = input {
            
            var countries = Array<String>()
            
            for code in  NSLocale.ISOCountryCodes() {
                if let country = NSLocale.systemLocale().displayNameForKey(NSLocaleCountryCode, value: code) {
                    countries.append(country)
                }
            }
            
            return countries.contains(countryName)
            
        } else {
            return false
        }
    }
}