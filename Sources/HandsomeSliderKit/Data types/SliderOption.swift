//
//  SliderOption.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-11.
//

import Foundation

/// A data type that represents a option within a `HandsomeSlider`.
public struct SliderOption: Hashable {
	/// A string that can uniquely identifiy an option within the `HandsomeSlider`.
	public let id: String
	/// A string to show directly below the slider indicator.
	public let title: String
	/// An optional string to show directly below the title string.
	public let subtitle: String?
	
	/**
	 Initializes a `HandsomeSlider` option.
	 
	 - Parameters:
			- id: A string that can uniquely identifiy an option within the `HandsomeSlider`.
			- title: A string to show directly below the slider indicator.
			- subtitle: An optional string to show directly below the title string. Defaults to nil.
	 */
	public init(id: String, title: String, subtitle: String? = nil) {
		self.id = id
		self.title = title
		self.subtitle = subtitle
	}
}
