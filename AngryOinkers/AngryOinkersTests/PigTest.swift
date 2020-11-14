//
//  PigTest.swift
//  AngryOinkersTests
//
//  Created by dev on 10/23/20.
//

import XCTest
@testable import AngryOinkers

class PigTest: XCTestCase {
    func testPigDebugDescription() {
        let sut = Pig(
            named: "Oink oink",
            role: "officer",
            page_url: "",
            complaint_count: 12,
            total_payments: 1220038
        )
        
        let actualValue = sut.debugDescription
        let expectedValue = "Pig(name: Oink oink, role: officer, cost: 1220038, complaints: 12"
        XCTAssertEqual(actualValue, expectedValue)
    }

}
