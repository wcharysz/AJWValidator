//
//  ValidationRuleDateRangeTests.swift
//  Validator
//
//  Created by Wojciech Charysz on 10.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

import XCTest
@testable import Validator

class ValidationRuleDateRangeTests: XCTestCase {
    
    func testThatItCanValidateDateWithinRange() {

        
        let today = Date()
        var daysCompononents = DateComponents()
        
        daysCompononents.day = -1
        let yesterday = Calendar.current.date(byAdding: daysCompononents, to: today, wrappingComponents: true)
        
        daysCompononents.day = 1
        let tomorrow = Calendar.current.date(byAdding: daysCompononents, to: today, wrappingComponents: true)
        
        let rule = ValidationRuleDateRange(min: yesterday!, max: tomorrow!, failureError: ValidationError(message: "💣"))
        
        daysCompononents.day = -2
        let ereyesterday = Calendar.current.date(byAdding: daysCompononents, to: today, wrappingComponents: true)
        
        let tooLate = Validator.validate(input: ereyesterday, rule: rule)
        XCTAssertFalse(tooLate.isValid)
        
        daysCompononents.day = 2
        let overmorrow = Calendar.current.date(byAdding: daysCompononents, to: today, wrappingComponents: true)
        
        let tooSoon = Validator.validate(input: overmorrow, rule: rule)
        XCTAssertFalse(tooSoon.isValid)
        
        let nilInput = Validator.validate(input: nil, rule: rule)
        XCTAssertFalse(nilInput.isValid)
        
        let onSchedule = Validator.validate(input: today, rule: rule)
        XCTAssertTrue(onSchedule.isValid)
    }
}
