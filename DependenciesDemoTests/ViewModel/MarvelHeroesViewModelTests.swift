//
//  MarvelHeroesViewModelTests.swift
//  DependenciesDemoTests
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import XCTest
import DependenciesDemoModels

@testable import DependenciesDemo

@MainActor
final class MarvelHeroesViewModelTests: XCTestCase {
	private var viewModel: MarvelHeroesViewModel!
	private var marvelHeroesNavigation: MarvelHeroesNavigation!

    override func setUp() {
		viewModel = MarvelHeroesViewModel()
		marvelHeroesNavigation = MarvelHeroesNavigation(path: [])
		viewModel.setup(navigation: marvelHeroesNavigation)
    }

	func testSetupNavigation() {
		let localViewModel = MarvelHeroesViewModel()
		XCTAssertNil(localViewModel.marvelHeroesNavigation)
		localViewModel.setup(navigation: marvelHeroesNavigation)
		XCTAssertNotNil(localViewModel.marvelHeroesNavigation)
	}

	func testSuccessFetchData() async {
		XCTAssertEqual(viewModel.superHeroes.count, 0)
		await viewModel.loadData()
		XCTAssertEqual(viewModel.superHeroes.count, 1)
	}

	func testNavigateToCharacter() {
		XCTAssertTrue(viewModel.marvelHeroesNavigation?.path.isEmpty == true)
		viewModel.navigate(to: .example)
		XCTAssertTrue(viewModel.marvelHeroesNavigation?.path.count == 1)
	}
}
