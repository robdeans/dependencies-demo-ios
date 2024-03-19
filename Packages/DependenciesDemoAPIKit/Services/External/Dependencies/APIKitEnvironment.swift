//
//  APIKitEnvironment.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import Foundation
import DependenciesDemoHelpers
import DependenciesDemoModels

public struct APIKitEnvironment {
	public var environment: () -> APIEnvironment
	public var initialize: (_ environment: APIEnvironment) -> Void
}

extension APIKitEnvironment: DependencyKey {
	public static var liveValue: APIKitEnvironment {
		var currentEnvironment: APIEnvironment!

		return APIKitEnvironment(
			environment: {
				guard let currentEnvironment else {
					LogFatal("Environment not set. Initialize environment using apiKitEnvironment.initialize(with environment:)")
				}
				return currentEnvironment
			},
			initialize: {
				currentEnvironment = $0
			}
		)
	}
}

extension DependencyValues {
	public var apiKitEnvironment: APIKitEnvironment {
		get { self[APIKitEnvironment.self] }
		set { self[APIKitEnvironment.self] = newValue }
	}
}
