//
//  MarvelHeroesService.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import DependenciesDemoModels

public struct MarvelHeroesService {
	public var fetchMarvelHeroes: () async throws -> [MarvelCharacter]
}

extension MarvelHeroesService: DependencyKey {
	public static var testValue: MarvelHeroesService { Self.previewValue }
}

extension DependencyValues {
	public var marvelHeroesService: MarvelHeroesService {
		get { self[MarvelHeroesService.self] }
		set { self[MarvelHeroesService.self] = newValue }
	}
}
