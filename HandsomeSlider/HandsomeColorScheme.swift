//
//  HandsomeColorScheme.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-13.
//

import SwiftUI

struct HandsomeColorScheme {
	let backgroundColor: Color
	let stepColor: Color
	let indicatorColor: Color
	
	static var defaultScheme: Self = {
		let backgroundColor: Color = .blue.opacity(0.2)
		let stepColor: Color = .white
		let indicatorColor: Color = .blue
		return HandsomeColorScheme(background: backgroundColor,
															 steps: stepColor,
															 indicator: indicatorColor)
	}()
	
	init(background: Color, steps: Color = .white, indicator: Color = .blue) {
		self.backgroundColor = background
		self.stepColor = steps
		self.indicatorColor = indicator
	}
}
