//
//  NetworkService.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Combine
import Dependencies
import Foundation
import FueledUtilsCombine

protocol NetworkService {
	var isOnline: AnyCurrentValuePublisher<Bool, Never> { get }
}

private enum NetworkServiceKey: DependencyKey {
	static let liveValue: NetworkService = NetworkServiceLive()
	static let previewValue: NetworkService = NetworkServiceTest()
	static let testValue: NetworkService = NetworkServiceTest()
}

extension DependencyValues {
	var networkService: NetworkService {
		get { self[NetworkServiceKey.self] }
		set { self[NetworkServiceKey.self] = newValue }
	}
}
