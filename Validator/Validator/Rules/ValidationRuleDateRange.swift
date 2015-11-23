//
//  ValidatorDateRangeRule.swift
//  Validator
//
//  Created by Wojciech Charysz on 10.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

import Foundation

public struct ValidationRuleDateRange: ValidationRule {
    
    public typealias InputType = NSDate
    
    public let min: NSDate
    public let max: NSDate
    public var failureError: ValidationErrorType
    
    public init(min: NSDate, max: NSDate, failureError: ValidationErrorType) {
        self.min = min
        self.max = max
        self.failureError = failureError
    }
    
    public func validateInput(input: NSDate?) -> Bool {

        if let inputDate = input {
            
            return inputDate.laterDate(self.min).isEqualToDate(inputDate) && inputDate.laterDate(self.max).isEqualToDate(self.max)
            
        } else {
            return false
        }
    }
}