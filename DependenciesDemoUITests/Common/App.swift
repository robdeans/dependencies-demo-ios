//
//  App.swift
//  DependenciesDemo
//
//  Created by Robert Deans on 03/19/2024.
//  Copyright © 2024 Fueled. All rights reserved.
//

import XCTest

final class TemplateApp {
	let app = XCUIApplication()
	let commonUIElements: CommonUIElements

	init() {
		commonUIElements = CommonUIElements(application: app)
	}

	func launch() {
		app.launchEnvironment = [
			"UITesting": "true"
		]
		app.launch()
	}

	var tabBar: XCUIElement {
		app.tabBars.firstMatch
	}

	var keyboard: XCUIElement {
		app.keyboards.firstMatch
	}

	func scrollView(key: String? = nil) -> XCUIElement {
		key.map { app.scrollViews[$0] } ?? app.scrollViews.firstMatch
	}

	func scrollView(id: String) -> XCUIElement {
		app.scrollViews.matching(identifier: id).firstMatch
	}

	func button(key: String? = nil) -> XCUIElement {
		key.map { app.buttons[$0] } ?? app.buttons.firstMatch
	}

	func button(id: String) -> XCUIElement {
		app.buttons.matching(identifier: id).firstMatch
	}

	func staticText(key: String) -> XCUIElement {
		app.staticTexts[key].firstMatch
	}

	func staticText(id: String) -> XCUIElement {
		app.staticTexts.matching(identifier: id).firstMatch
	}

	func image(key: String) -> XCUIElement {
		app.images[key]
	}

	func image(id: String) -> XCUIElement {
		app.images.matching(identifier: id).firstMatch
	}

	func textField(id: String) -> XCUIElement {
		app.textFields.matching(identifier: id).firstMatch
	}

	func otherElement(id: String) -> XCUIElement {
		app.otherElements.matching(identifier: id).firstMatch
	}

	func tap() {
		app.tap()
	}

	func swipeUp() {
		app.swipeUp()
	}

	func swipeDown() {
		app.swipeDown()
	}
}
