//
//  MarvelHeroDetailsView.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import DependenciesDemoHelpers
import DependenciesDemoModels
import SwiftUI

struct MarvelHeroDetailsView: View {
	@EnvironmentObject private var marvelHeroesNavigation: MarvelHeroesNavigation
	@StateObject var viewModel: MarvelHeroDetailsViewModel

	var body: some View {
		VStack(spacing: 16) {
			if let character = viewModel.character {
				MarvelCharacterView(character: character)
			}
			Text("This is a detailed view")
				.font(.subheadline)
				.accessibilityAddTraits(.isStaticText)
		}
		.accessibilityIdentifier(UITestIDs.MarvelHeroDetailsView.parent.rawValue)
		.task {
			viewModel.setup(navigation: marvelHeroesNavigation)
		}
	}
}

#Preview {
	MarvelHeroDetailsView(
		viewModel: MarvelHeroDetailsViewModel(
			character: MarvelCharacter.example
		)
	)
}
