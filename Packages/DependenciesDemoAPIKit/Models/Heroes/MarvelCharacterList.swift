//
//  MarvelCharacterList.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

public struct MarvelCharacterList: Codable {
	enum CodingKeys: String, CodingKey {
		case results
	}
	public let results: [MarvelCharacter]
}

public struct ResponseData: Codable {
	enum CodingKeys: String, CodingKey {
		case data
	}
	public let data: MarvelCharacterList
}
