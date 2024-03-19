//
//  OnboardingNavigation.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 11/22/23.
//  Copyright © 2023 Fueled. All rights reserved.
//

import DependenciesDemoHelpers
import SwiftUI

final class OnboardingNavigation: NavigationStackManager {
	@Published var path: [Path] = []
}

extension OnboardingNavigation {
	enum Path: NavigationPathProtocol {
		case login
		case onboarding

		var destination: some View {
			switch self {
			case .onboarding:
				Text("Onboarding")
			case .login:
				Text("Login")
			}
		}
	}
}
