//
//  AppCenterApplicationService.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import ArkanaKeys
import UIKit

final class AppCenterApplicationService: NSObject, ApplicationService {
	private static let maxFileSize = 7 * 1000 * 1000

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
		Crashes.delegate = self
		AppCenter.start(
			withAppSecret: ArkanaKeys.Global().appCenterSecret,
			services: [
				Analytics.self,
				Crashes.self,
			]
		)

		return false
	}
}

extension AppCenterApplicationService: CrashesDelegate {
	func attachments(with crashes: Crashes, for errorReport: ErrorReport) -> [ErrorAttachmentLog]? {
		nil
	}
}
