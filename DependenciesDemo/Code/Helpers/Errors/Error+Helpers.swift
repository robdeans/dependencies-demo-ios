//
//  Error+Helpers.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation
import DependenciesDemoHelpers

extension Error {
	var verboseDescription: String {
		"<[\(self)]: Title=\(displayableError.title ?? "(default)") Description=\(displayableError.message ?? "(default)") ButtonTitle=\(displayableError.buttonTitle ?? "(default)")>"
	}

	var userFriendlyTitle: String? {
		LogError("Error \(self): \(verboseDescription)")
		return displayableError.title
	}

	var userFriendlyMessage: String? {
		LogError("Error \(self): \(verboseDescription)")
		return displayableError.message
	}

	var userFriendlyDescription: String {
		LogError("Error \(self): \(verboseDescription)")
		return displayableError.message ?? displayableError.title ?? localizedDescription
	}
}
