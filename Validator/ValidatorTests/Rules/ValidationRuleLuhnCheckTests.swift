//
//  ValidationRuleLuhnCheckTests.swift
//  Validator
//
//  Created by Wojciech Charysz on 16.09.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

import XCTest
@testable import Validator

class ValidationRuleLuhnCheckTests: XCTestCase {
    
    func testThatItCanValidateCardsNumbers() {
        
        let sampleCardNumber = "4532763921347060"
        
        let rule = ValidationRuleLuhnCheck(failureError: ValidationError(message: "💣"))
        
        let correctCard = Validator.validate(input: sampleCardNumber, rule: rule)
        XCTAssertTrue(correctCard.isValid)
        
        let nullCardNumber = "000000000000000"
        let nullCard = Validator.validate(input: nullCardNumber, rule: rule)
        XCTAssertFalse(nullCard.isValid)
        
        let falseCardNumber = "123456789"
        let falseCard = Validator.validate(input: falseCardNumber, rule: rule)
        XCTAssertFalse(falseCard.isValid)
        
        let nilInput = Validator.validate(input: nil, rule: rule)
        XCTAssertFalse(nilInput.isValid)
    }
}
