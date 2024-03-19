//
//  MarvelHeroDetailsViewUITests.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import XCTest

// MARK: Initial Setup
final class MarvelHeroDetailsViewUITests: XCTestCase {
	private let app = TemplateApp()

	override func setUpWithError() throws {
		continueAfterFailure = false
		app.launch()
	}

	private func navigateToMarvelHeroDetailsView() {
		heroesListFirstItem.tap()
	}
}

// MARK: Tests
extension MarvelHeroDetailsViewUITests {
	func testMarvelHeroDetails() {
		let marvelHeroDetailsViewExists1 = marvelHeroDetailsView.waitForExistence(timeout: 2)
		XCTAssertFalse(marvelHeroDetailsViewExists1, "MarvelHeroDetailsView exists")

		navigateToMarvelHeroDetailsView()

		let marvelHeroDetailsViewExists2 = marvelHeroDetailsView.waitForExistence(timeout: 2)
		XCTAssertTrue(marvelHeroDetailsViewExists2, "Did not navigate to MarvelHeroDetailsView")
	}
}

// MARK: Items
extension MarvelHeroDetailsViewUITests {
	var marvelHeroDetailsView: XCUIElement {
		app.staticText(id: UITestIDs.MarvelHeroDetailsView.parent.rawValue)
	}

	var heroesListFirstItem: XCUIElement {
		app.staticText(id: MarvelHeroDetailsViewUITests.ObjectNames.heroesListFirstItem.rawValue)
	}
}

extension MarvelHeroDetailsViewUITests {
	enum ObjectNames: String {
		case heroesListFirstItem = "HeroesListItem0"
	}
}
