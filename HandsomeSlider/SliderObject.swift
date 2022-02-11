//
//  SliderObject.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-11.
//

import Foundation

struct SliderObject: Hashable {
	let id: String
	let title: String
	let subtitle: String

	/**
	 Calculates where in the `HandsomeSlider` a certain index is located.
	 
	 Step 1: TBC
	 Step 2: TBC
	 Step 3: TBC
	 */
	static func getLocation(for index: Int, inListWithCount count: Int, viewWidth: Double) -> Double {
		let count = Double(count + 1)
		let halfCount = Double(count / 2)
		let indexDouble = Double(index) - halfCount
		let divider = Double(indexDouble / count)
		let newLocation = (viewWidth * divider)
		return newLocation
	}
}
