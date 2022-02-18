//
//  HandsomeColorScheme.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-13.
//

import SwiftUI

/// A data type that defines a color scheme for the `HandsomeSlider`.
public struct HandsomeColorScheme {
	/// The color to apply to the background of the `HandsomeSlider`.
	public let backgroundColor: Color
	/// The color to apply to the dots within the `HandsomeSlider`.
	public let dotColor: Color
	/// The color to apply to the indicator within the `HandsomeSlider`.
	public let indicatorColor: Color
	
	/// The default, blue-ish color scheme for the `HandsomeSlider`.
	public static var defaultScheme: Self = {
		let backgroundColor: Color = .blue.opacity(0.2)
		let stepColor: Color = .white
		let indicatorColor: Color = .blue
		return HandsomeColorScheme(background: backgroundColor,
															 dots: stepColor,
															 indicator: indicatorColor)
	}()
	
	/**
	 Initializes a new color scheme .
	 
	 - Parameters:
			- background: The color to apply to the background of the `HandsomeSlider`
			- steps: The color to apply to the dots representing the different options of the `HandsomeSlider`
			- indicator: The color to apply to the indicator within the `HandsomeSlider`
	 */
	public init(background: Color, dots: Color, indicator: Color) {
		self.backgroundColor = background
		self.dotColor = dots
		self.indicatorColor = indicator
	}
}
