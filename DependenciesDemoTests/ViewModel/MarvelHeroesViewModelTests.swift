//
//  MarvelHeroesViewModelTests.swift
//  DependenciesDemoTests
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

@testable import DependenciesDemo
import Dependencies
import DependenciesDemoModels
import XCTest

final class MarvelHeroesViewModelTests: XCTestCase {
	private struct SomeError: Error {}
}

// MARK: - Top level swapping
///
///	These tests override each layer's fetch method (be it `Service` or `Repository`)
///	and call the respective `fetch-` method from the `ViewModel`
extension MarvelHeroesViewModelTests {
	/// Test will only succeed if `@Dependency` is declared locally within `ViewModel` and not within method
	@MainActor
	func testFetchHeroesServiceSubstitute() async {
		let viewModel = withDependencies {
			$0.marvelHeroesService.fetchMarvelHeroes = {
				throw SomeError()
			}
		} operation: {
			MarvelHeroesViewModel()
		}

		await viewModel.loadServiceData()
		XCTAssert(viewModel.error != nil)
		XCTAssert(viewModel.error is SomeError)
	}

	/// This test will succeed regardless of whether the `@Dependency` is declared within the method or locally within the `ViewModel`
	///
	/// Also will pass regardless of where `@Dependency(\.marvelHeroesService)` is declared within `HeroRepositoryClass`
	@MainActor
	func testFetchHeroesClassSubstitute() async {
		let viewModel = withDependencies {
			$0.heroRepositoryClass.getAllMarvelCharacters = { _ in
				throw SomeError()
			}
		} operation: {
			MarvelHeroesViewModel()
		}

		await viewModel.loadClassData()
		XCTAssert(viewModel.error != nil)
		XCTAssert(viewModel.error is SomeError)
	}

	/// Test will only succeed if `@Dependency` is declared locally within `ViewModel` and not within method
	///
	/// Test will ALSO succeed if `@Dependency(\.marvelHeroesService)` is declared locally within `HeroRepositoryStruct.getAllMarvelCharacters` method
	@MainActor
	func testFetchHeroesStruct1() async {
		let viewModel = withDependencies {
			$0.heroRepositoryStruct.getAllMarvelCharacters = { _ in
				throw SomeError()
			}
		} operation: {
			MarvelHeroesViewModel()
		}

		await viewModel.loadStructData()
		XCTAssert(viewModel.error != nil)
		XCTAssert(viewModel.error is SomeError)
	}
}

// MARK: - Skip-level swapping
///
/// These tests swap out the Service method but call the respective Repository fetches
///
///	Each fails, indicating that overriding the `marvelHeroesService` and injecting into `MarvelHeroesViewModel`
///	skips the Dependencies found in the `Repository` models.
///
///	Interestingly, declaring these Dependencies outside the scope of the methods and within the `ViewModel`
///	successfully overrides and throws an error, passing the tests
extension MarvelHeroesViewModelTests {
	/// In contrast to the `class` test above, this test will only pass when the `@Dependency` is declared locally within the `ViewModel` and not within the method.
	///
	/// Similarly the placement within `HeroRepositoryClass` matters, with tests failing if the `@Dependency(\.marvelHeroesService)` is declared within the method to be swapped
	@MainActor
	func testFetchHeroesServiceWithClassSubstitute() async {
		let viewModel = withDependencies {
			$0.marvelHeroesService.fetchMarvelHeroes = {
				throw SomeError()
			}
		} operation: {
			MarvelHeroesViewModel()
		}

		await viewModel.loadClassData()
		XCTAssert(viewModel.error != nil)
		XCTAssert(viewModel.error is SomeError)
	}

	/// This test similarly only passes when the `@Dependency` is declared locally within the `ViewModel` and outside of the method.
	///
	/// AND when `@Dependency(\.marvelHeroesService)` is declared outside of `HeroRepositoryStruct.getAllMarvelCharacters` method
	@MainActor
	func testFetchHeroesServiceWithStructSubstitute() async {
		let viewModel = withDependencies {
			$0.marvelHeroesService.fetchMarvelHeroes = {
				throw SomeError()
			}
		} operation: {
			MarvelHeroesViewModel()
		}

		await viewModel.loadStructData()
		XCTAssert(viewModel.error != nil)
		XCTAssert(viewModel.error is SomeError)
	}
}
