//
//  NetworkService+Live.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Combine
import DependenciesDemoHelpers
import Foundation
import FueledUtilsCombine
import Network

final class NetworkServiceLive: NetworkService {
	private let isOnlineSubject = CurrentValueSubject<Bool, Never>(false)
	let isOnline: AnyCurrentValuePublisher<Bool, Never>

	private let monitor = NWPathMonitor()

	init() {
		isOnline = isOnlineSubject.eraseToAnyCurrentValuePublisher()

		monitor.pathUpdateHandler = { [weak self] path in
			switch path.status {
			case .satisfied:
				self?.isOnlineSubject.send(true)
			case .unsatisfied, .requiresConnection:
				self?.isOnlineSubject.send(false)
			@unknown default:
				LogError("Unhandled case \(path.status)")
			}
		}

		startMonitoring()
	}

	private func startMonitoring() {
		let queue = DispatchQueue(label: "NetworkMonitor")
		monitor.start(queue: queue)
	}
}
