//
//  APIError.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

public enum APIError: LocalizedError {
	case noInternetConnection
	case serverError(statusCode: Int, response: [String: Any] = [:])
	case unknownError

	var message: String {
		switch self {
		case .noInternetConnection:
			"No internet connection available"
		case let .serverError(statusCode, dict):
			"Failed with status code: \(statusCode), response: \(dict)"
		case .unknownError:
			"Unable to provide an error response"
		}
	}
}
