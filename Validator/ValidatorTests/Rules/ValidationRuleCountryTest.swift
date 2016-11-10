//
//  ValidationRuleCountryTest.swift
//  Validator
//
//  Created by Wojciech Charysz on 23.11.15.
//  Copyright © 2015 adamjwaite.co.uk. All rights reserved.
//

import XCTest
@testable import Validator

class ValidationRuleCountryTest: XCTestCase {
    

    func testThatItCanValidateCountryName() {
        
        let sampleName = "Germany"
        let wrongName = "Germania"
        let localisedName = Locale.current.localizedString(forRegionCode: "DE")
                    
        let rule = ValidationRuleCountry(failureError: ValidationError(message: "💣"))
        
        let correctCountry1 = Validator.validate(input: sampleName, rule: rule)
        XCTAssertTrue(correctCountry1.isValid)
        
        let correctCountry2 = Validator.validate(input: localisedName, rule: rule)
        XCTAssertTrue(correctCountry2.isValid)
        
        let wrongCountry = Validator.validate(input: wrongName, rule: rule)
        XCTAssertFalse(wrongCountry.isValid)
        
        let emptyString = Validator.validate(input: "", rule: rule)
        XCTAssertFalse(emptyString.isValid)
    }
}
