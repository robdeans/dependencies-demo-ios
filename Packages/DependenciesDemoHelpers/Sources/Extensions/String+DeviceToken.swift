//
//  String+PushNotificationToken.swift
//  DependenciesDemoHelpers
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import Foundation

extension String {
	/// Create a string from the push notification token
	public init!(deviceToken: Data) {
		if deviceToken.count != 64 {
			return nil
		}

		var string = ""
		for byte in deviceToken {
			string.append(String(format: "%02X", byte))
		}
		self.init(string)
	}
}
