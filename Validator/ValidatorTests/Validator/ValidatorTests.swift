/*

 ValidatorTests.swift
 Validator

 Created by @adamwaite.

 Copyright (c) 2015 Adam Waite. All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

*/

import XCTest
@testable import Validator

class ValidatorTests: XCTestCase {
    
    func testThatItCanEvaluateRules() {
        
        let err = ValidationError(message: "💣")
        
        let rule = ValidationRuleCondition<String>(failureError: err) { string in
            if let string = string, string.characters.count > 0 {
                return true
            }
            
            return false
        }
        
        let invalid = Validator.validate(input: "", rule: rule)
        XCTAssertEqual(invalid, ValidationResult.invalid([err]))
        
        let valid = Validator.validate(input: "😀", rule: rule)
        XCTAssertEqual(valid, ValidationResult.valid)
        
    }
    
    func testThatItCanEvaluateMultipleRules() {

        let err1 = ValidationError(message: "💣")
        let err2 = ValidationError(message: "💣💣")
        
        var ruleSet = ValidationRuleSet<String>()
        ruleSet.addRule(ValidationRuleLength(min: 1, failureError: err1))
        ruleSet.addRule(ValidationRuleCondition<String>(failureError: err2) { $0 == "😀" })
        
        let definitelyInvalid = Validator.validate(input: "", rules: ruleSet)
        XCTAssertEqual(definitelyInvalid, ValidationResult.invalid([err1, err2]))
        
        let partiallyValid = "😁".validate(rules: ruleSet)
        XCTAssertEqual(partiallyValid, ValidationResult.invalid([err2]))

        let valid = "😀".validate(rules: ruleSet)
        XCTAssertEqual(valid, ValidationResult.valid)
        
    }
    
    func testThatItCanEvaluateMultipleRulesWithPriorities() {
        
        let err1 = ValidationError(message: "💣")
        let err2 = ValidationError(message: "💣💣")
        
        var ruleSet = ValidationRuleSet<String>()
        
        let moreImportant = 2
        let lessImportant = 1
        ruleSet.addRule(ValidationRuleLength(min: 1, failureError: err1), priority: moreImportant)
        ruleSet.addRule(ValidationRuleCondition<String>(failureError: err2) { $0 == "😀" }, priority: lessImportant)
        
        let definitelyInvalid = Validator.validate(input: "", rules: ruleSet)
        XCTAssertEqual(definitelyInvalid, ValidationResult.invalid([err1, err2]))

        switch definitelyInvalid {
        case.invalid(let failures):
            
            XCTAssertTrue(failures.first?.priority ?? 0 > failures.last?.priority ?? 0)
            XCTAssertTrue(failures.first?.priority == moreImportant)
            XCTAssertTrue(failures.last?.priority == lessImportant)
             break
        case.valid:
            
            XCTAssertFalse(definitelyInvalid.isValid)
             break
        }
        
        let partiallyValid = "😁".validate(rules: ruleSet)
        XCTAssertEqual(partiallyValid, ValidationResult.invalid([err2]))
        
        let valid = "😀".validate(rules: ruleSet)
        XCTAssertEqual(valid, ValidationResult.valid)
        

    }
    
}
