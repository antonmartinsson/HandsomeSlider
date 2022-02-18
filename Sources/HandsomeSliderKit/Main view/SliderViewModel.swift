//
//  SliderViewModel.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-13.
//

import Foundation

/// Holds various data that the HandsomeSlider uses frequently to display and update its user interface.
class SliderViewModel {
	
	let sliderOptions: [SliderOption]
	let firstPosition: Double
	let lastPosition: Double
	let colorScheme: HandsomeColorScheme
	
	private var positionsDictionary: [SliderOption : Double] = [:]
	private var sliderOptionsDictionary: [Double : SliderOption] = [:]
	
	init(sliderOptions: [SliderOption],
			 viewWidth: Double,
			 colorScheme: HandsomeColorScheme) {
		self.sliderOptions = sliderOptions
		self.colorScheme = colorScheme
		self.firstPosition = -(viewWidth / 2) + HandsomeSliderIndicator.radius
		self.lastPosition = (viewWidth / 2) - HandsomeSliderIndicator.radius
		
		for (index, selectionable) in sliderOptions.enumerated() {
			let position = getLocation(for: index + 1, inListWithCount: sliderOptions.count, viewWidth: viewWidth)
			positionsDictionary[selectionable] = position
			sliderOptionsDictionary[position] = selectionable
		}
	}
	
	func getPosition(for selectionable: SliderOption) -> Double {
		return positionsDictionary[selectionable] ?? 0
	}
	
	func getSelectionable(for position: Double) -> SliderOption? {
		return sliderOptionsDictionary[position]
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
			let optionCount = (Double(count) - 1)
			let amountOfSteps = Double(index - 1)
			let centerOfFirstDotToCenterOfLastDot = (viewWidth - (HandsomeSlider.insidePadding * 2) - (Dot.radius * 2))
			let firstPosition = -(centerOfFirstDotToCenterOfLastDot / 2)
			return firstPosition + (centerOfFirstDotToCenterOfLastDot / optionCount * amountOfSteps)
		}
	}
}