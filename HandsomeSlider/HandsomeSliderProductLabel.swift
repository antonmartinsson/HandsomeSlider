//
//  HandsomeSliderProductLabel.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI
import StoreKit

struct HandsomeSliderProductLabel: View {
	@Environment(\.accessibilityReduceMotion) var reduceMotion

	let selectionable: SliderObject?
	@Binding var sliderOffset: CGFloat
	
	var body: some View {
		if let title = selectionable?.title, let subtitle = selectionable?.subtitle {
			withAnimation(reduceMotion ? nil : .easeInOut) {
				VStack(alignment: .center, spacing: 4) {
					Text(title)
						.fontWeight(.light)
						.font(.callout)
						.offset(x: sliderOffset, y: 65)
					Text(subtitle)
						.fontWeight(.medium)
						.font(.title3)
						.offset(x: sliderOffset, y: 65)
				}
			}
		} else {
			withAnimation(reduceMotion ? nil : .easeInOut) {
				Text("🤔")
					.offset(x: sliderOffset, y: 65)
			}
		}
	}
}
