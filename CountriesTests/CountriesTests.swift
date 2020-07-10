//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Sergiu Todirascu on 7/4/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import XCTest
@testable import Countries

class CountriesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        _ = CountryMock().countries
    }

}
