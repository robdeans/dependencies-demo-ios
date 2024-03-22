//
//  HeroRepositoryStruct.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 3/19/24.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import DependenciesDemoHelpers
import DependenciesDemoModels
import DependenciesDemoServices

struct HeroRepositoryStruct {
	/// Returns an array `[Marvel]`
	///
	/// If `refresh: true` the array is fetched from MarvelHeroesService, otherwise the locally stored array is provided
	var getAllMarvelCharacters: (_ refresh: Bool) async throws -> [MarvelCharacter]

	/// Fetches a contact from a local dictionary; O(1) lookup time
	var getMarvelCharacter: (_ id: MarvelCharacter.ID) -> MarvelCharacter?
}

extension DependencyValues {
	var heroRepositoryStruct: HeroRepositoryStruct {
		get { self[HeroRepositoryStruct.self] }
		set { self[HeroRepositoryStruct.self] = newValue }
	}
}

extension HeroRepositoryStruct: DependencyKey {
	static var liveValue: HeroRepositoryStruct {
		/// Apparently this cannot be set _inside_ the `getAllContacts` method because
		/// this causes the method to not successly override using `withDependencies` in testing
		@Dependency(\.marvelHeroesService) var marvelHeroesService

		// swiftlint:disable identifier_name
		var _marvelCharacters: [MarvelCharacter] = []
		var marvelCharactersDictionary: [MarvelCharacter.ID: MarvelCharacter] = [:]

		return HeroRepositoryStruct(
			getAllMarvelCharacters: { refresh in
				guard refresh || _marvelCharacters.isEmpty else {
					return _marvelCharacters
				}
				/// Referencing `marvelHeroesService` here does not allow `withDependencies` to override methods when testing, DEPENDING on where `@Dependency(\.heroRepositoryStruct)` is declared in its encompassing object (is `ViewModel`).
				///
				/// See `MarvelHeroesViewModelTests` struct-related tests for more details
//				 @Dependency(\.marvelHeroesService) var marvelHeroesService

				_marvelCharacters = try await marvelHeroesService.fetchMarvelHeroes()
				marvelCharactersDictionary = Dictionary(
					_marvelCharacters.map { ($0.id, $0) },
					uniquingKeysWith: { _, last in last }
				)
				LogInfo("Repository returning \(_marvelCharacters.count) characters(s)")
				return _marvelCharacters
			},
			getMarvelCharacter: { marvelCharactersDictionary[$0] }
		)
	}
	static var previewValue: HeroRepositoryStruct { .liveValue }
	static var testValue: HeroRepositoryStruct { .liveValue }
}
