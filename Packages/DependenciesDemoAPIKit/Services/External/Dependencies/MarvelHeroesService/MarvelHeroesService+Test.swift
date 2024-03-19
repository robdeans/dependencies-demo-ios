//
//  MarvelHeroesService+Test.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation
import DependenciesDemoModels

// MARK: Preview & Tests
extension MarvelHeroesService {
	public static var previewValue: MarvelHeroesService {
		MarvelHeroesService(
			fetchMarvelHeroes: {
				let character = MarvelCharacter(
					name: "A.I.M.",
					id: 1011334,
					description: "AIM is a terrorist organization bent on destroying the world.",
					thumbnail: MarvelCharacterThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", ext: "jpg")
				)
				return [character]
			}
		)
	}
}
