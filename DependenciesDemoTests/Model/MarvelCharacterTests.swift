//
//  MarvelCharacterTests.swift
//  DependenciesDemoTests
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import DependenciesDemoModels
import XCTest

final class MarvelCharacterTests: XCTestCase {

	func testSuccessParser() {
		let json = """
		{
			"id": 1011334,
			"name": "3-D Man",
			"description": "",
			"modified": "2014-04-29T14:18:17-0400",
			"thumbnail": {
				"path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
				"extension": "jpg"
			},
		}
		""".data(using: .utf8)!

		let character = try! JSONDecoder().decode(MarvelCharacter.self, from: json)

		XCTAssertNotNil(character)
	}
}
