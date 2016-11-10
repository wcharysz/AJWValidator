//
//  ValidatorDateRangeRule.swift
//  Validator
//
//  Created by Wojciech Charysz on 10.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

import Foundation

public struct ValidationRuleDateRange: ValidationRule {
    
    public typealias InputType = Date
    
    public let min: Date
    public let max: Date
    public var failureError: ValidationErrorType
    
    public init(min: Date, max: Date, failureError: ValidationErrorType) {
        self.min = min
        self.max = max
        self.failureError = failureError
    }
    
    public func validateInput(_ input: Date?) -> Bool {

        guard let inputDate = input else {
            return false
        }
        
        if inputDate < min {
            return false
        }
        
        if inputDate > max {
            return false
        }
        
        return true
    }
}
