//
//  MarvelCharacterRepository.swift
//  DependenciesDemoTests
//
//  Created by Robert Deans on 3/19/24.
//  Copyright © 2024 Fueled. All rights reserved.
//

@testable import DependenciesDemo
@testable import DependenciesDemoModels
import Dependencies
import XCTest

final class MarvelCharacterRepositoryTests: XCTestCase {
	private struct SomeError: Error {}

	/// Observations:
	/// Test succeeds regardless of whether `liveValue` or `testValue` is used.
	/// However, if `marvelHeroesService` is declared within the method variable in `HeroRepositoryStruct`,
	/// error will not propogate and test will fail.
	func testGetAllContactsStructError() async {
		let marvelCharacterRepository = withDependencies {
			$0.marvelHeroesService.fetchMarvelHeroes = {
				throw SomeError()
			}
		} operation: {
			HeroRepositoryStruct.liveValue
			//HeroRepositoryStruct.testValue
		}

		do {
			_ = try await marvelCharacterRepository.getAllMarvelCharacters(true)
			XCTFail("Error should be thrown on try statement")
		} catch {
			XCTAssert(error is SomeError)
		}
	}

	/// Observations:
	/// Test succeeds regardless of whether `liveValue` or `testValue` is used.
	/// However, if `marvelHeroesService` is declared within the method variable in `HeroRepositoryClass`,
	/// error will not propogate and test will fail.
	func testGetAllContactsClassError() async {
		let marvelCharacterRepository = withDependencies {
			$0.marvelHeroesService.fetchMarvelHeroes = {
				throw SomeError()
			}
		} operation: {
			HeroRepositoryClass.liveValue
			//HeroRepositoryClass.testValue
		}

		do {
			_ = try await marvelCharacterRepository.getAllMarvelCharacters(true)
			XCTFail("Error should be thrown on try statement")
		} catch {
			XCTAssert(error is SomeError)
		}
	}
}
