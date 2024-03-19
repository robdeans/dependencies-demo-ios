//
//  View+Helpers.swift
//  DependenciesDemoHelpers
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import SwiftUI

// MARK: - Segue to push
extension View {
	public func segue<T, Destination: View>(item: Binding<T?>, destination: @escaping (T) -> Destination) -> some View {
		navigationDestination(
			isPresented: .init(
				get: { item.wrappedValue != nil },
				set: { item.wrappedValue = $0 ? item.wrappedValue : nil }
			)
		) {
			if let item = item.wrappedValue {
				destination(item)
			}
		}
	}

	public func segue<T: View>(isPresented: Binding<Bool>, @ViewBuilder destination: @escaping () -> T) -> some View {
		navigationDestination(isPresented: isPresented, destination: destination)
	}
}
