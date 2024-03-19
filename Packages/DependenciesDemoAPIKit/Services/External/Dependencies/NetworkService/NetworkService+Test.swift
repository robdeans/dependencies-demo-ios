//
//  NetworkService+Test.swift
//  DependenciesDemoAPIKit
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import FueledUtilsCombine

final class NetworkServiceTest: NetworkService {
	let isOnline: AnyCurrentValuePublisher<Bool, Never>

	init(isOnlineValue: Bool = true) {
		isOnline = AnyCurrentValuePublisher<Bool, Never>(isOnlineValue)
	}
}
