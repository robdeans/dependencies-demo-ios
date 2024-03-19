//
//  APIRequest.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

struct APIRequest<Response: Decodable> {
	var path: String
	var query: [String: any Decodable]?
	var method: Method = .get
	var headers: [String: String]?
	var decoder: JSONDecoder = .init()

	enum Method {
		case get
		case post([String: Any])
		case put([String: Any])

		var stringValue: String {
			switch self {
			case .get:
				return "GET"
			case .post:
				return "POST"
			case .put:
				return "PUT"
			}
		}
	}
}

struct EmptyResponse: Decodable {}
typealias NoResponseRequest = APIRequest<EmptyResponse>

extension APIRequest: CustomStringConvertible {
	var description: String {
"""
	Request(
	path: \(path),
	query: \(query ?? [:]),
	method: \(method),
	headers: \(headers?.mapValues { $0.description.localizedCaseInsensitiveContains("Bearer") ? "***" : $0 } ?? [:])
)
"""
	}
}
