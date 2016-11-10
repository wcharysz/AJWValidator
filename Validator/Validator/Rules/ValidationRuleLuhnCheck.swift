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
    
    public func validateInput(_ input: String?) -> Bool {
        
        guard let inputNumbers = input else {
            return false
        }
        
        var sum = 0
        var even = 0
            
        //Checks if the card consists only zeros
        var controlSum = 0
        
        let digitArray = inputNumbers.characters.map { (character) -> Int? in
            return Int(String(character))
        }
        
        for number in digitArray.reversed() {
            if let number = number {
                let addend = number * (1 << (even & 1))
                even += 1
                sum += addend % 10 + addend / 10
                controlSum += number
            }
        }

        return (sum % 10 == 0 ) && (controlSum > 0)
    }
}
