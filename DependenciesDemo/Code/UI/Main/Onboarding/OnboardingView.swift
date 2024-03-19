//
//  OnboardingView.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 11/22/23.
//  Copyright © 2023 Fueled. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
	@StateObject private var onboardingNavigation = OnboardingNavigation()

	var body: some View {
		NavigationStack(path: $onboardingNavigation.path) {
			EmptyView()
				.navigationDestination(for: onboardingNavigation)
		}
		.environmentObject(onboardingNavigation)
	}
}
