//
//  App.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Dependencies
import DependenciesDemoServices
import SwiftUI

@main
struct DependenciesDemoApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
	var hasOnboarded = true

	var body: some Scene {
		WindowGroup {
			if ProcessInfo.processInfo.environment["UITesting"] == "true" {
				UITestingView()
			} else {
				if hasOnboarded {
					MarvelHeroesView()
				} else {
					OnboardingView()
				}
			}
		}
	}
}

struct UITestingView: View {
	var body: some View {
		withDependencies {
			$0.marvelHeroesService = MarvelHeroesService.previewValue
		} operation: {
			MarvelHeroesView()
		}
	}
}
