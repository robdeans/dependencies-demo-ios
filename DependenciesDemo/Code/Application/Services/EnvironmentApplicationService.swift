//
//  EnvironmentApplicationService.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024
//  Copyright © 2024 Fueled. All rights reserved.
//

#if canImport(UIKit)
import Dependencies
import DependenciesDemoConfig
import DependenciesDemoHelpers
import DependenciesDemoModels
import UIKit

enum DefaultKeys {
	fileprivate static var environmentName: String = "environmentName"
}

final class EnvironmentApplicationService: NSObject, ApplicationService {
	override init() {
		let settingsBundleURL = Bundle.main.url(forResource: "Settings", withExtension: "bundle")!
		let settingsBundle = Bundle(url: settingsBundleURL)!
		// Iterate over all .plist in the settings bundle
		for url in settingsBundle.urls(forResourcesWithExtension: "plist", subdirectory: nil) ?? [] {
			let plistContent = NSDictionary(contentsOf: url) as! [String: Any]
			let settings = plistContent["PreferenceSpecifiers"] as! [[String: Any]]
			var defaults: [String: Any] = [:]
			for setting in settings {
				if let key = setting["Key"] as? String, let defaultValue = setting["DefaultValue"] {
					defaults[key] = defaultValue
				}
			}
			UserDefaults.standard.register(defaults: defaults)
		}
	}

	var preferredEnvironment: APIEnvironment {
		let environment: APIEnvironment
		if let currentEnvironment = UserDefaults.standard.string(forKey: DefaultKeys.environmentName).flatMap({ APIEnvironment(rawValue: $0) }) {
			environment = currentEnvironment
		} else {
			let logMessage = "Invalid environment name in settings bundle (\(UserDefaults.standard.string(forKey: DefaultKeys.environmentName) ?? "<none>")), did you forget to update the settings bundle's plist file?"
			#if DEBUG
			LogFatal(logMessage)
			#else
			environment = APIEnvironment.allCases.first!
			LogWarning("\(logMessage) The environment will default to \(environment)")
			UserDefaults.standard.set(environment.rawValue, forKey: DefaultKeys.environmentName)
			#endif
		}
		return environment
	}

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
		DependenciesDemoConfig.initialize(environment: environment)
		return false
	}
}

extension EnvironmentApplicationService {
	var environment: APIEnvironment {
#if PRODUCTION
		APIEnvironment.production.configuration
#else
		self.preferredEnvironment
#endif
	}
}
#endif
