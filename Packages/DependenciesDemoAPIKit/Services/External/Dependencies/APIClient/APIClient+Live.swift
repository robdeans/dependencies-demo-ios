//
//  APIClient+Live.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import DependenciesDemoHelpers
import DependenciesDemoModels
import Foundation

final class APIClientLive: APIClient {
	@Dependency(\.apiKitEnvironment.environment) var environment

	func request<Response>(_ request: APIRequest<Response>) async throws -> Response where Response: Decodable {
		do {
			@Dependency(\.networkService) var networkService

			guard networkService.isOnline.value else {
				throw APIError.noInternetConnection
			}
			let urlRequest = try request.makeRequest(using: environment().baseURL)
			let (data, response) = try await URLSession.shared.data(for: urlRequest)
			try response.validate(with: data)
			return try request.decoder.decode(Response.self, from: data)
		} catch {
			LogError(error.localizedDescription)
			throw error
		}
	}

	func noResponseRequest(_ request: NoResponseRequest) async throws {
		do {
			@Dependency(\.networkService) var networkService

			guard networkService.isOnline.value else {
				throw APIError.noInternetConnection
			}
			let urlRequest = try request.makeRequest(using: environment().baseURL)
			let (data, response) = try await URLSession.shared.data(for: urlRequest)
			try response.validate(with: data)
		} catch {
			LogError(error.localizedDescription)
			throw error
		}
	}
}

extension APIRequest {
	fileprivate func makeRequest(using baseURL: URL) throws -> URLRequest {
		guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
			throw URLError(.badURL)
		}

		components.path = path.isEmpty ? "" : "/" + path

		if let query {
			let queryItems = createQueryItems(from: query)
			components.queryItems = queryItems
		}

		guard let url = components.url else {
			throw URLError(.unsupportedURL)
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = method.stringValue

		if case let .post(body) = method {
			urlRequest.httpBody = body.encodeToJSON
			urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		} else if case let .put(body) = method {
			urlRequest.httpBody = body.encodeToJSON
			urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		}

		headers?.forEach { key, value in
			urlRequest.setValue(value.description, forHTTPHeaderField: key)
		}
		return urlRequest
	}

	private func createQueryItems(from query: [String: any Decodable]) -> [URLQueryItem] {
		query.flatMap { key, value in
			// If the value is an array, create multiple items, otherwise create a single item.
			if let arrayOfValues = value as? [any CustomStringConvertible] {
				return arrayOfValues.map { URLQueryItem(name: key, value: "\($0)") }
			} else {
				return [URLQueryItem(name: key, value: "\(value)")]
			}
		}
	}
}

fileprivate extension URLResponse {
	func validate(with data: Data? = nil) throws {
		guard let httpResponse = self as? HTTPURLResponse else {
			return
		}

		if (200...226).contains(httpResponse.statusCode) {
			return
		}

		var responseDict = [String: Any]()
		if  let data,
			let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
			responseDict = dict
		}

		throw APIError.serverError(statusCode: httpResponse.statusCode, response: responseDict)
	}
}
