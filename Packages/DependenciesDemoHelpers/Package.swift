// swift-tools-version:5.9
//
//  Package.swift
//  DependenciesDemoHelpers
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import PackageDescription

let package = Package(
	name: "DependenciesDemoHelpers",
	platforms: [
		.macOS(.v13), .iOS(.v16), .tvOS(.v12), .watchOS(.v4),
	],
	products: [
		.library(
			name: "DependenciesDemoHelpers",
			targets: ["DependenciesDemoHelpers"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.0"),
	],
	targets: [
		.target(
			name: "DependenciesDemoHelpers",
			dependencies: [
				"KeychainAccess",
			],
			path: "Sources"
		),
	]
)
