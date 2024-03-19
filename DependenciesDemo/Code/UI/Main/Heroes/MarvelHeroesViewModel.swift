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
	@Published private(set) var isLoading = false

	func setup(navigation: MarvelHeroesNavigation) {
		marvelHeroesNavigation = navigation
	}

	func loadData() async {
		LogInfo("Loading data for fetchMarvelHeroes")
		do {
			isLoading = true
			@Dependency(\.marvelHeroesService) var marvelHeroesService
			superHeroes = try await marvelHeroesService.fetchMarvelHeroes()
		} catch {
			// TODO: Handle errors
		}

		isLoading = false
	}

	func navigate(to character: MarvelCharacter) {
		guard let marvelHeroesNavigation else {
			LogError("No navigation stack provided")
			return
		}
		marvelHeroesNavigation.path.append(.heroDetails(character))
	}
}
