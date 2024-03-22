//
//  MarvelHeroesViewModel.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Combine
import Dependencies
import DependenciesDemoHelpers
import DependenciesDemoModels

@MainActor
final class MarvelHeroesViewModel: ObservableObject {
	private(set) var marvelHeroesNavigation: MarvelHeroesNavigation?
	@Published private(set) var superHeroes: [MarvelCharacter] = []
	@Published private(set) var classHeroes: [MarvelCharacter] = []
	@Published private(set) var structHeroes: [MarvelCharacter] = []
	@Published private(set) var isLoading = false
	var error: Error?

	@Dependency(\.marvelHeroesService) private var marvelHeroesService
	@Dependency(\.heroRepositoryClass) private var heroRepositoryClass
	@Dependency(\.heroRepositoryStruct) private var heroRepositoryStruct

	func setup(navigation: MarvelHeroesNavigation) {
		marvelHeroesNavigation = navigation
	}

	///
	///	Comment out encapsulated `@Dependency` from within each of the methods
	///	allowing local variables to be applied.
	///
	///	This results in successful overrides and passing unit tests
	func loadServiceData() async {
		do {
			@Dependency(\.marvelHeroesService) var marvelHeroesService
			superHeroes = try await marvelHeroesService.fetchMarvelHeroes()
		} catch {
			self.error = error
		}
	}

	func loadClassData() async {
		do {
//			@Dependency(\.heroRepositoryClass) var heroRepositoryClass
			classHeroes = try await heroRepositoryClass.getAllMarvelCharacters(true)
		} catch {
			self.error = error
		}
	}

	func loadStructData() async {
		do {
//			@Dependency(\.heroRepositoryStruct) var heroRepositoryStruct
			structHeroes = try await heroRepositoryStruct.getAllMarvelCharacters(true)
		} catch {
			self.error = error
		}
	}

	func navigate(to character: MarvelCharacter) {
		guard let marvelHeroesNavigation else {
			LogError("No navigation stack provided")
			return
		}
		marvelHeroesNavigation.path.append(.heroDetails(character))
	}
}
