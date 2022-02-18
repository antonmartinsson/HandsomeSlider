//
//  HandsomeSliderIndicator.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI
import StoreKit

struct HandsomeSliderIndicator: View {
	@Environment(\.accessibilityReduceMotion) var reduceMotion
	
	@Binding var sliderOffset: Double
	@Binding var sliderOption: SliderOption?
	let viewModel: SliderViewModel
	
	static let radius: Double = 25
	
	var body: some View {
		let size: Double = HandsomeSliderIndicator.radius * 2
		
		ZStack {
			Circle()
				.frame(width: size, height: size)
				.foregroundColor(viewModel.colorScheme.indicatorColor)
			
			if let title = sliderOption?.title {
				withAnimation(reduceMotion ? nil : .easeInOut) {
					VStack(alignment: .center, spacing: 4) {
						Text(title)
							.fontWeight(.light)
							.font(.callout)
							.offset(y: sliderOption?.subtitle == nil ? 50 : 65)
						if let subtitle = sliderOption?.subtitle {
							Text(subtitle)
								.fontWeight(.medium)
								.font(.title3)
								.offset(y: sliderOption?.subtitle == nil ? 50 : 65)
						}
					}
				}
			} else {
				withAnimation(reduceMotion ? nil : .easeInOut) {
					Text("🤔")
						.offset(y: 50)
				}
			}
		}
		.offset(x: sliderOffset)
		.sliderGesture(sliderOffset: $sliderOffset, viewModel: viewModel)
	}
}
