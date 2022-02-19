//
//  HandsomeSliderGesture.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI

extension View {
	func sliderGesture(sliderOffset: Binding<Double>, viewModel: SliderViewModel) -> some View {
		self.modifier(SlideGesture(sliderOffset: sliderOffset, viewModel: viewModel))
	}
}

struct SlideGesture: ViewModifier {
	@Environment(\.accessibilityReduceMotion) var reduceMotion
	@Binding var sliderOffset: Double
	let viewModel: SliderViewModel
	
	func body(content: Content) -> some View {
		content
			.highPriorityGesture(
				DragGesture()
					.onChanged({ value in
						sliderOffset = value.location.x - 25
					})
					.onEnded({ value in
						withAnimation(reduceMotion ? nil : .easeInOut) {
							let closestValue = viewModel.getClosestValue(forLocation: value.location.x - 25)
							sliderOffset = closestValue
						}
					})
			)
	}
}
