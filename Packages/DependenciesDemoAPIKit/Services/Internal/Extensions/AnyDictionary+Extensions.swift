//
//  AnyDictionary+Extensions.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

extension [String: Any] {
	var encodeToJSON: Data? {
		try? JSONSerialization.data(withJSONObject: self, options: [])
	}
}
