//
//  SelectionableHelper.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-13.
//

import Foundation

class SelectionableHelper {
	
	let sliderObjects: [SliderObject]
	let firstPosition: Double
	let lastPosition: Double
	let colorScheme: HandsomeColorScheme
	
	private var positionsDictionary: [SliderObject : Double] = [:]
	private var sliderObjectsDictionary: [Double : SliderObject] = [:]
	
	init(sliderObjects: [SliderObject],
			 viewWidth: Double,
			 colorScheme: HandsomeColorScheme) {
		self.sliderObjects = sliderObjects
		self.colorScheme = colorScheme
		self.firstPosition = -(viewWidth / 2) + 25
		self.lastPosition = (viewWidth / 2) - 25
		
		for (index, selectionable) in sliderObjects.enumerated() {
			let position = getLocation(for: index + 1, inListWithCount: sliderObjects.count, viewWidth: viewWidth)
			positionsDictionary[selectionable] = position
			sliderObjectsDictionary[position] = selectionable
		}
	}
	
	func getPosition(for selectionable: SliderObject) -> Double {
		return positionsDictionary[selectionable] ?? 0
	}
	
	func getSelectionable(for position: Double) -> SliderObject? {
		return sliderObjectsDictionary[position]
	}
	
	/**
	 Calculates where in the `HandsomeSlider` a certain index is located.
	 As the slider is centrally aligned in a ZStack, position 0 represents the very middle of the slider.
	 
	 
	 */
	func getLocation(for index: Int, inListWithCount count: Int, viewWidth: Double) -> Double {
		if index == 1 {
			return firstPosition
		} else if index == count {
			return lastPosition
		} else {
			return firstPosition + (((viewWidth - (HandsomeSlider.insidePadding * 2)) / ((Double(count) - 1)) * Double(index - 1)))
		}
	}
}
