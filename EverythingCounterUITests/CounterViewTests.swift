//
//  CounterViewTests.swift
//  EverythingCounterUITests
//
//  Created by 伊藤凌也 on 2019/05/23.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import XCTest
@testable import EverythingCounter
import UIKit
import ReactorKit

class CounterViewTests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let reactor = CounterViewReactor()
        reactor.stub.isEnabled = true
        let counterVC = CounterViewController()
        counterVC.reactor = reactor
        
        counterVC.addCounterButton.sendActions(for: .touchUpInside)
        
        XCTAssertNotNil(counterVC.createCounterVC?.onDismissed)
    }

}
