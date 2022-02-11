//
//  TipSliderGesture.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI

extension View {
	func tipSliderGesture(sliderOffset: Binding<CGFloat>, selectionables: [SliderObject], viewWidth: Double) -> some View {
		self.modifier(SlideGesture(sliderOffset: sliderOffset, selectionables: selectionables, viewWidth: viewWidth))
	}
}

struct SlideGesture: ViewModifier {
	@Environment(\.accessibilityReduceMotion) var reduceMotion
	@Binding var sliderOffset: CGFloat
	let selectionables: [SliderObject]
	let viewWidth: Double
	
	func getClosestValue(forLocation location: Double) -> Double {
		var possibleValues: [Double] = .empty
		for (index, _) in selectionables.enumerated() {
			let oneBasedIndex = index + 1
			let count = selectionables.count
			let sliderLocation = SliderObject.getLocation(for: oneBasedIndex, inListWithCount: count, viewWidth: viewWidth)
			possibleValues.append(sliderLocation)
		}
		
		guard let over = possibleValues.first(where: { $0 >= location }) else { return viewWidth - (viewWidth / 2) - 25 }
		guard let under = possibleValues.last(where: { $0 <= location }) else { return 0 - (viewWidth / 2) + 25}
		
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
