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

        
        let today = NSDate()
        let daysCompononents = NSDateComponents()
        
        daysCompononents.day = -1
        let yesterday = NSCalendar.currentCalendar().dateByAddingComponents(daysCompononents, toDate: today, options: NSCalendarOptions.WrapComponents)
        
        daysCompononents.day = 1
        let tomorrow = NSCalendar.currentCalendar().dateByAddingComponents(daysCompononents, toDate: today, options: NSCalendarOptions.WrapComponents)
        
        let rule = ValidationRuleDateRange(min: yesterday!, max: tomorrow!, failureError: ValidationError(message: "💣"))
        
        daysCompononents.day = -2
        let ereyesterday = NSCalendar.currentCalendar().dateByAddingComponents(daysCompononents, toDate: today, options: NSCalendarOptions.WrapComponents)
        
        
        let tooLate = Validator.validate(input: ereyesterday, rule: rule)
        XCTAssertFalse(tooLate.isValid)
        
        
        daysCompononents.day = 2
        let overmorrow = NSCalendar.currentCalendar().dateByAddingComponents(daysCompononents, toDate: today, options: NSCalendarOptions.WrapComponents)
        
        
        let tooSoon = Validator.validate(input: overmorrow, rule: rule)
        XCTAssertFalse(tooSoon.isValid)
        
        
        let nilInput = Validator.validate(input: nil, rule: rule)
        XCTAssertFalse(nilInput.isValid)
    }
}
