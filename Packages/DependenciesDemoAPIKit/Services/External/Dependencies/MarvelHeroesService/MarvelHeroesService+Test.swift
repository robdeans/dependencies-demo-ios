//
//  MarvelHeroesService+Test.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import DependenciesDemoModels

// MARK: Preview & Tests
extension MarvelHeroesService {
	public static var previewValue: MarvelHeroesService {
		MarvelHeroesService(
			fetchMarvelHeroes: {
				[
					MarvelCharacter(
						name: "1",
						id: 1,
						description: "",
						thumbnail: .mock
					),
					MarvelCharacter(
						name: "2",
						id: 2,
						description: "",
						thumbnail: .mock
					),
					MarvelCharacter(
						name: "3",
						id: 3,
						description: "",
						thumbnail: .mock
					),
				]
			}
		)
	}
}
