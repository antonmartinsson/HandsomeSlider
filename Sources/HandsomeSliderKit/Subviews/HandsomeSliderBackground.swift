//
//  HandsomeSliderBackground.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI

struct HandsomeSliderBackground: View {
	let viewModel: SliderViewModel
	@Binding var sliderOffset: Double

	var body: some View {
		let sliderOptions = viewModel.sliderOptions
		let height = (HandsomeSliderIndicator.radius * 2) - 10
		
		ZStack(alignment: .center) {
			RoundedRectangle(cornerRadius: (height) / 2)
				.foregroundColor(viewModel.colorScheme.backgroundColor)
				.frame(height: height)
				.shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 0)
			HStack(spacing: 0) {
				ForEach(sliderOptions, id:\.self) { option in
					Dot(newLocation: viewModel.getPosition(for: option), sliderOffset: $sliderOffset)
						.foregroundColor(viewModel.colorScheme.dotColor)
					if option != sliderOptions.last {
						Spacer()
					}
				}
			}
			.padding(HandsomeSlider.insidePadding)
		}
	}
}

struct Dot: View {
	@Environment(\.accessibilityReduceMotion) var reduceMotion

	static let radius: Double = 6
	let newLocation: Double
	@Binding var sliderOffset: Double
	
	var body: some View {
		Button {
			withAnimation(reduceMotion ? nil : .easeInOut) {
				sliderOffset = newLocation
			}
		} label: {
			Circle()
				.frame(width: Dot.radius * 2, height: Dot.radius * 2)
		}
	}
}
