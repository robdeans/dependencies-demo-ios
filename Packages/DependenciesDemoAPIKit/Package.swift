// swift-tools-version:5.9
//
//  Package.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//
import PackageDescription

let package = Package(
	name: "DependenciesDemoAPIKit",
	platforms: [
		.macOS(.v13), .iOS(.v16), .tvOS(.v12), .watchOS(.v4),
	],
	products: [
		.library(
			name: "DependenciesDemoAPIKit",
			targets: ["DependenciesDemoServices", "DependenciesDemoModels", "DependenciesDemoConfig"]
		),
	],
	dependencies: [
		// global
		.package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),

		// local
		.package(name: "ArkanaKeys", path: "../ArkanaKeys"),
		.package(name: "DependenciesDemoHelpers", path: "../DependenciesDemoHelpers"),
	],
	targets: [
		.target(
			name: "DependenciesDemoServices",
			dependencies: [
				// global
				.product(name: "Dependencies", package: "swift-dependencies"),
				// local
				"ArkanaKeys",
				"DependenciesDemoHelpers",
				"DependenciesDemoModels",
			],
			path: "./Services"
		),
		.target(
			name: "DependenciesDemoModels",
			path: "./Models"
		),
		.target(
			name: "DependenciesDemoConfig",
			dependencies: [
				// global
				.product(name: "Dependencies", package: "swift-dependencies"),

				// local
				"ArkanaKeys",
				"DependenciesDemoModels",
				"DependenciesDemoServices",
			],
			path: "./Config"
		)
	]
)
