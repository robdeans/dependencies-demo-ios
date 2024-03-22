//
//  HeroRepositoryClass.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 3/20/24.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import DependenciesDemoHelpers
import DependenciesDemoModels
import DependenciesDemoServices

final class HeroRepositoryClass {
	/// Returns an array `[Marvel]`
	///
	/// If `refresh: true` the array is fetched from MarvelHeroesService, otherwise the locally stored array is provided
	var getAllMarvelCharacters: (_ refresh: Bool) async throws -> [MarvelCharacter]

	/// Fetches a contact from a local dictionary; O(1) lookup time
	var getMarvelCharacter: (_ id: MarvelCharacter.ID) -> MarvelCharacter?

	init(
		getAllMarvelCharacters: @escaping (Bool) async throws -> [MarvelCharacter],
		getMarvelCharacter: @escaping (MarvelCharacter.ID) -> MarvelCharacter?
	) {
		self.getAllMarvelCharacters = getAllMarvelCharacters
		self.getMarvelCharacter = getMarvelCharacter
	}
}

extension DependencyValues {
	var heroRepositoryClass: HeroRepositoryClass {
		get { self[HeroRepositoryClass.self] }
		set { self[HeroRepositoryClass.self] = newValue }
	}
}

extension HeroRepositoryClass: DependencyKey {
	static var liveValue: HeroRepositoryClass {
		/// Apparently this cannot be set _inside_ the `getAllContacts` method because
		/// this causes the method to not successly override using `withDependencies` in testing
		@Dependency(\.marvelHeroesService) var marvelHeroesService

		// swiftlint:disable identifier_name
		var _marvelCharacters: [MarvelCharacter] = []
		var marvelCharactersDictionary: [MarvelCharacter.ID: MarvelCharacter] = [:]

		return HeroRepositoryClass(
			getAllMarvelCharacters: { refresh in
				guard refresh || _marvelCharacters.isEmpty else {
					return _marvelCharacters
				}
				/// Referencing `marvelHeroesService` here does not allow `withDependencies` to override methods when testing.
				/// Comment out following line to pass tests
//				@Dependency(\.marvelHeroesService) var marvelHeroesService

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
	static var previewValue: HeroRepositoryClass { .liveValue }
	static var testValue: HeroRepositoryClass { .liveValue }
}
