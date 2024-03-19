//
//  DependenciesDemoAPIKit.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import DependenciesDemoModels
import DependenciesDemoServices

public enum DependenciesDemoConfig {
	public static func initialize(environment: APIEnvironment) {
		@Dependency(\.apiKitEnvironment) var apiKitEnvironment
		apiKitEnvironment.initialize(environment)
	}
}
