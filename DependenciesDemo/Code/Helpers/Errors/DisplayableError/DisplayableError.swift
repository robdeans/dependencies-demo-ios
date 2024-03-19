//
//  DisplayableError.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

protocol DisplayableError: Error {
	var title: String? { get }
	var message: String? { get }
	var buttonTitle: String? { get }
}

protocol DisplayableSwiftError: DisplayableError, SwiftError {
}
