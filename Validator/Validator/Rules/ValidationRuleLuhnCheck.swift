//
//  ValidationRuleLuhnCheck.swift
//  Validator
//
//  Created by Wojciech Charysz on 16.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

import Foundation

public struct ValidationRuleLuhnCheck: ValidationRule {
    
    public typealias InputType = String

    public var failureError: ValidationErrorType
    
    public init(failureError: ValidationErrorType) {
        self.failureError = failureError
    }
    
    public func validateInput(input: String?) -> Bool {
        
        if let inputNumbers = input {
            
            var sum = 0
            var even = 0
            
            //Checks if the card consists only zeros
            var controlSum = 0
            
            var digitArray:[Int] = []
            
            for i in inputNumbers.characters {
                let stringNumber = String(i)
                guard let intNumber = Int(stringNumber) else {
                    return false
                }
                
                digitArray.append(intNumber)
            }
            
            let numberLength = digitArray.count
            
            for var i = numberLength - 1; i >= 0; i-- {
                let number = digitArray[i]
                let addend = number * (1 << (even++ & 1))
                sum += addend % 10 + addend / 10
                controlSum += number
            }
            
            return (sum % 10 == 0 ) && (controlSum > 0)
            
        } else {
            return false
        }
    }
}
