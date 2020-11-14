//
//  PigServiceTests.swift
//  AngryOinkersTests
//
//  Created by dev on 10/23/20.
//

import XCTest
@testable import AngryOinkers

class PigServiceTests: XCTestCase {
    var sut: PigService!
    
    override func setUp() {
        self.sut = PigService()
    }
    
    override func tearDown() {
        self.sut = nil
    }
    
    //NOTE: this is a flaky test
    //because the API host is a bit flaky
    //when host is first called after several hours, it spins up a dormant server which takes some time
    //if at first it times out, try again (and again and again) to prove that it only failed when the host was spinning up
    func testAPI_returnsSuccessfulResult() {
        //Given
        var pigs: [Pig]!
        var error: Error?
        
        let promise = expectation(description: "Completion handler is invoked")
        
        //When
        self.sut.getPigs(completion: { data, shouldntHappen in
            pigs = data
            error = shouldntHappen
            promise.fulfill()
        })
        
        wait(for: [promise], timeout: 15)
        
        //Then
        XCTAssertNotNil(pigs)
        XCTAssertNil(error)
    }
    

}
