//
//  Keychain+Shared.swift
//  DependenciesDemoHelpers
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import KeychainAccess

extension Keychain {
	public static let shared = Keychain(service: "com.fueled.DependenciesDemo")
}
