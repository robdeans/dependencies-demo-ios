//
//  MarvelHeroesViewUITests.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import XCTest

// MARK: Initial Setup
final class MarvelHeroesViewUITests: XCTestCase {
	private let app = TemplateApp()

	override func setUpWithError() throws {
		continueAfterFailure = false
		app.launch()
	}
}

// MARK: Tests
extension MarvelHeroesViewUITests {
	func testScrollView() {
		let scrollView = app.scrollView(id: UITestIDs.MarvelHeroesView.scrollView.rawValue)
		let scrollViewExists = scrollView.waitForExistence(timeout: 2)
		XCTAssertTrue(scrollViewExists, "Did not find marvelHeroesViewScrollView")

		scrollView.swipeUp(velocity: .slow)
		scrollView.swipeUp()
		scrollView.swipeDown(velocity: .fast)
	}
}
