//
//  APIEnvironment.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

public enum APIEnvironment: String, Codable, CaseIterable {
	case development = "dev"
	case qa
	case production = "prod"
}

public extension APIEnvironment {
	var baseURL: URL {
		switch self {
		case .development:
			return URL(string: "https://gateway.marvel.com")!
		case .qa:
			return URL(string: "https://gateway.marvel.com")!
		case .production:
			return URL(string: "https://gateway.marvel.com")!
		}
	}
}
