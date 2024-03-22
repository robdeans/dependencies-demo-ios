//
//  MarvelHeroDetailsViewModel.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Combine
import DependenciesDemoModels

final class MarvelHeroDetailsViewModel: ObservableObject {
	private(set) var marvelHeroesNavigation: MarvelHeroesNavigation?
	@Published private(set) var character: MarvelCharacter?

	init(character: MarvelCharacter) {
		self.character = character
	}

	init(id: Int) {
		character = .example
	}

	func setup(navigation: MarvelHeroesNavigation) {
		marvelHeroesNavigation = navigation
	}
}
