//
//  MarvelHeroesView.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import DependenciesDemoHelpers
import SwiftUI

struct MarvelHeroesView: View {
	@StateObject private var marvelHeroesNavigation: MarvelHeroesNavigation
	@StateObject private var viewModel = MarvelHeroesViewModel()

	init(
		navigationPath: [MarvelHeroesNavigation.Path] = []
	) {
		_marvelHeroesNavigation = StateObject(wrappedValue: MarvelHeroesNavigation(path: navigationPath))
	}

	var body: some View {
		NavigationStack(path: $marvelHeroesNavigation.path) {
			rootView
				.navigationDestination(for: marvelHeroesNavigation)
		}
		.environmentObject(marvelHeroesNavigation)
		.task {
			viewModel.setup(navigation: marvelHeroesNavigation)
			await viewModel.loadServiceData()
		}
	}

	@ViewBuilder
	private var rootView: some View {
		if viewModel.isLoading {
			ProgressView()
		} else {
			contentView
		}
	}

	private var contentView: some View {
		ScrollView {
			LazyVStack {
				titleView
				Spacer()
				heroesListView
			}
		}
		.accessibilityIdentifier(UITestIDs.MarvelHeroesView.scrollView.rawValue)
	}

	private var titleView: some View {
		HStack {
			Text("Sample view to demonstrate accessibility features. Unit tests also included for reference.")
				.font(.headline)
				.accessibilityAddTraits(.isHeader)
			Image(.Images.Sample.sample)
				.renderingMode(.template)
				.foregroundColor(.imagePrimary)
		}
	}

	private var heroesListView: some View {
		ForEach(viewModel.superHeroes.indices, id: \.self) { index in
			let character = viewModel.superHeroes[index]
			MarvelCharacterView(character: character)
				.accessibilityIdentifier("HeroesListItem\(index)")
				.onTapGesture {
					viewModel.navigate(to: character)
				}
		}
		.accessibilityLabel(String(localized: "List of \(viewModel.superHeroes.count) marvel super heroes."))
	}
}

#Preview {
	MarvelHeroesView()
}
