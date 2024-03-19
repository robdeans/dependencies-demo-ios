//
//  MarvelCharacter.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

public struct MarvelCharacter: Codable, Hashable {
	public let name: String
	public let id: Int
	public let description: String
	public let thumbnail: MarvelCharacterThumbnail

	public var imageString: String? {
		guard let path = thumbnail.path, let ext = thumbnail.ext else {
			return nil
		}
		return path + "." + ext
	}

	public init(name: String, id: Int, description: String, thumbnail: MarvelCharacterThumbnail) {
		self.name = name
		self.id = id
		self.description = description
		self.thumbnail = thumbnail
	}
}

extension MarvelCharacter: Equatable {
	public static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
		lhs.id == rhs.id
	}
}

extension MarvelCharacter {
	public static var example: MarvelCharacter {
		MarvelCharacter(
			name: "A.I.M",
			id: 102123,
			description: "AIM is a terrorist organization bent on destroying the world.",
			thumbnail: MarvelCharacterThumbnail(path: "", ext: "")
		)
	}
}
