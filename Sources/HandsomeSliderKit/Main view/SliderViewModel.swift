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
			 colorScheme: HandsomeColorScheme = .defaultScheme) {
		self.sliderOptions = sliderOptions
		self.colorScheme = colorScheme
		self.firstPosition = -(viewWidth / 2) + HandsomeSliderIndicator.radius
		self.lastPosition = (viewWidth / 2) - HandsomeSliderIndicator.radius
		
		for (index, selectionable) in sliderOptions.enumerated() {
			let position = getLocation(forDotNumber: index + 1, inListWithCount: sliderOptions.count, viewWidth: viewWidth)
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
	 Returns the value in the slider which is closest to the location supplied to the method.
	 
	 - Parameter location: The x location in the slider you want to find the closest value to.
	 - Returns: The value in the slider closest to the supplied location.
	 */
	func getClosestValue(forLocation location: Double) -> Double {
		var possibleValues: [Double] = .empty
		for selectionable in viewModel.sliderOptions {
			possibleValues.append(viewModel.getPosition(for: selectionable))
		}
		
		guard let over = possibleValues.first(where: { $0 >= location }) else { return viewModel.lastPosition }
		guard let under = possibleValues.last(where: { $0 <= location }) else { return viewModel.firstPosition }
		
		let diffOver = over - location
		let diffUnder = location - under
		
		return (diffOver < diffUnder) ? over : under
	}
	
	/**
	 Calculates where in the `HandsomeSlider` a certain index is located.
	 As the slider is centrally aligned in a ZStack, position 0 represents the very middle of the slider.
	 
	 - Parameters:
			- index:
			- count:
			- viewWidth:
	 - Returns:
	 */
	func getLocation(forDotNumber index: Int, inListWithCount count: Int, viewWidth: Double) -> Double {
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
