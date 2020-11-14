//
//  PigListViewControllerTests.swift
//  AngryOinkersTests
//
//  Created by dev on 10/23/20.
//

import XCTest
@testable import AngryOinkers

class PigListViewControllerTests: XCTestCase {
    var sut: PigListViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navController = storyboard.instantiateInitialViewController() as! UINavigationController
        self.sut = navController.topViewController as? PigListViewController
        
        UIApplication.shared.windows
            .filter { $0.isKeyWindow }
            .first!
            .rootViewController = self.sut
        
        XCTAssertNotNil(navController.view)
        XCTAssertNotNil(self.sut.view)
    }
    
    func testTableView_loadsPigs() {
        //Given
        let mockPigService = MockPigService()
        let mockPigs = [
            Pig(
                named: "Oinkyoink",
                role: "officer",
                page_url: "",
                complaint_count: 12,
                total_payments: 1220038
            ),
            Pig(
                named: "Oinkster",
                role: "lieutenant",
                page_url: "",
                complaint_count: 25,
                total_payments: 665434
            ),
            Pig(
                named: "Oinkstoooften",
                role: "detective",
                page_url: "",
                complaint_count: 2,
                total_payments: 12038
            )
        ]
        mockPigService.mockPigs = mockPigs
        self.sut.viewDidLoad()
        
        self.sut.pigService = mockPigService
        self.sut.sounder = mockPigs
        
        XCTAssertEqual(0, self.sut.tableView.numberOfRows(inSection: 0))
        
        //When
        self.sut.viewWillAppear(false)
        
        //Then
        XCTAssertEqual(mockPigs.count, self.sut.sounder.count)
        XCTAssertEqual( mockPigs.count, self.sut.tableView.numberOfRows(inSection: 0))
    }

    class MockPigService: PigService {
        var mockPigs: [Pig]?
        var mockError: Error?
        
        override func getPigs(completion: @escaping ([Pig]?, Error?) -> ()) {
            print(mockPigs?.count)
            print(mockError)
            completion(mockPigs, mockError)
        }
    }
    
}
