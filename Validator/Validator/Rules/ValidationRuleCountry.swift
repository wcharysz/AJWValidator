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
    
    public func validateInput(_ input: InputType?) -> Bool {
        
        guard let countryName = input else {
            return false
        }
            
        let countries = Locale.isoRegionCodes.map({ (code) -> String? in
            return Locale.current.localizedString(forRegionCode: code)
        })
            
        return countries.contains(where: { (country) -> Bool in
            return country == countryName
        })
    }
}
