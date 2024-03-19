//
//  View+Navigation.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 11/22/23.
//  Copyright © 2023 Fueled. All rights reserved.
//

import SwiftUI

public protocol NavigationPathProtocol<Destination>: Hashable {
	associatedtype Destination: View
	@ViewBuilder var destination: Destination { get }
}

public protocol NavigationStackManager<Path>: AnyObject, ObservableObject {
	associatedtype Path: NavigationPathProtocol
	var path: [Path] { get set }
}

extension NavigationStackManager {
	public func dismissToRoot() {
		path.removeAll()
	}
}

extension View {
	public func navigationDestination<Manager: NavigationStackManager>(
		for manager: Manager
	) -> some View {
		navigationDestination(for: Manager.Path.self) {
			$0.destination
		}
	}
}
