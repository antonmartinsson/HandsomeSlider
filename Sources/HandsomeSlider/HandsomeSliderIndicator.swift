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
	@Binding var selectionable: SliderObject?
	let helper: SelectionableHelper
	
	static let sliderRadius: Double = 25
	
	var body: some View {
		let size: Double = HandsomeSliderIndicator.sliderRadius * 2
		
		ZStack {
			Circle()
				.frame(width: size, height: size)
				.foregroundColor(helper.colorScheme.indicatorColor)
			
			if let title = selectionable?.title {
				withAnimation(reduceMotion ? nil : .easeInOut) {
					VStack(alignment: .center, spacing: 4) {
						Text(title)
							.fontWeight(.light)
							.font(.callout)
							.offset(y: 65)
						if let subtitle = selectionable?.subtitle {
							Text(subtitle)
								.fontWeight(.medium)
								.font(.title3)
								.offset(y: 65)
						}
					}
				}
			} else {
				withAnimation(reduceMotion ? nil : .easeInOut) {
					Text("🤔")
						.offset(y: 65)
				}
			}
		}
		.offset(x: sliderOffset)
		.sliderGesture(sliderOffset: $sliderOffset, helper: helper)
	}
}
