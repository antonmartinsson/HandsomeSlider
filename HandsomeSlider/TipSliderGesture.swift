//
//  TipSliderGesture.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI

extension View {
	func tipSliderGesture(sliderOffset: Binding<Double>, helper: SelectionableHelper) -> some View {
		self.modifier(SlideGesture(sliderOffset: sliderOffset, helper: helper))
	}
}

struct SlideGesture: ViewModifier {
	@Environment(\.accessibilityReduceMotion) var reduceMotion
	@Binding var sliderOffset: Double
	let helper: SelectionableHelper
	
	func getClosestValue(forLocation location: Double) -> Double {
		var possibleValues: [Double] = .empty
		for selectionable in helper.sliderObjects {
			possibleValues.append(helper.getPosition(for: selectionable))
		}
		
		guard let over = possibleValues.first(where: { $0 >= location }) else { return helper.lastPosition }
		guard let under = possibleValues.last(where: { $0 <= location }) else { return helper.firstPosition }
		
		let diffOver = over - location
		let diffUnder = location - under
		
		return (diffOver < diffUnder) ? over : under
	}
	
	func body(content: Content) -> some View {
		content
			.highPriorityGesture(
				DragGesture()
					.onChanged({ value in
						sliderOffset = value.location.x - 25
					})
					.onEnded({ value in
						withAnimation(reduceMotion ? nil : .easeInOut) {
							let closestValue = getClosestValue(forLocation: value.location.x - 25)
							sliderOffset = closestValue
						}
					})
			)
	}
}
