//
//  APIClient.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import Foundation

protocol APIClient {
	@discardableResult
	func request<Response: Decodable>(_ request: APIRequest<Response>) async throws -> Response
}

protocol Endpoint {
	associatedtype Response: Decodable

	var baseURL: URL { get }
	var path: String { get }
	var query: [String: String] { get }
	var method: APIRequest<Response>.Method { get }
	var headers: [String: String]? { get }
}

extension Endpoint {
	func build() -> APIRequest<Response> {
		.init(
			path: path,
			query: query,
			method: method,
			headers: headers
		)
	}
}

enum APIClientKey: DependencyKey {
	static var liveValue: any APIClient = APIClientLive()
}

extension DependencyValues {
	var apiClient: any APIClient {
		get { self[APIClientKey.self] }
		set { self[APIClientKey.self] = newValue }
	}
}
