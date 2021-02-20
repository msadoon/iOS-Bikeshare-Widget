//
//  bikeshare_widgetTests.swift
//  bikeshare-widgetTests
//
//  Created by Mubarak Sadoon on 2021-02-19.
//

import XCTest
import Nimble

@testable import bikeshare_widget

class bikeshare_widgetTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let stationService = StationsStoreImpl()
        
        stationService.refresh()

        expect(try stationService.stationsResult.get()).toEventuallyNot(beEmpty())
        
        print((try? stationService.stationsResult.get())?.debugDescription ?? "Error")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
