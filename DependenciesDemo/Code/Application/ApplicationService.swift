//
//  ApplicationService.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import UIKit

protocol ApplicationService: UIApplicationDelegate {
}

extension ApplicationService {
	var window: UIWindow? {
		UIApplication.shared.delegate?.window.flatMap { $0 }
	}
}
