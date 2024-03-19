//
//  MarvelHeroDetailsViewModelTests.swift
//  DependenciesDemoTests
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import XCTest
import DependenciesDemoModels

@testable import DependenciesDemo

@MainActor
final class MarvelHeroDetailsViewModelTests: XCTestCase {
	private var viewModel: MarvelHeroDetailsViewModel!
	private var marvelHeroesNavigation: MarvelHeroesNavigation!

	func testHeroDetailsInit() async {
		viewModel = MarvelHeroDetailsViewModel(character: .example)
		XCTAssertNotNil(viewModel.character)
	}

	func testHeroDetailsIDInit() async {
		viewModel = MarvelHeroDetailsViewModel(id: MarvelCharacter.example.id)
		XCTAssertNotNil(viewModel.character)
	}

	func testSetupNavigation() {
		let character = MarvelCharacter.example
		viewModel = MarvelHeroDetailsViewModel(character: character)
		marvelHeroesNavigation = MarvelHeroesNavigation(path: [.heroDetails(character)])

		XCTAssertNil(viewModel.marvelHeroesNavigation)
		viewModel.setup(navigation: marvelHeroesNavigation)
		XCTAssertNotNil(viewModel.marvelHeroesNavigation)
	}
}
