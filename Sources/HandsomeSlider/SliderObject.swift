//
//  SliderObject.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-11.
//

import Foundation

public struct SliderObject: Hashable {
	public let id: String
	public let title: String
	public let subtitle: String?
	
	public init(id: String, title: String, subtitle: String?) {
		self.id = id
		self.title = title
		self.subtitle = subtitle
	}
}
