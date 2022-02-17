//
//  HandsomeSliderBackground.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI

struct HandsomeSliderBackground: View {
	let helper: SelectionableHelper
	@Binding var sliderOffset: Double

	var body: some View {
		let sliderObjects = helper.sliderObjects
		let height = (HandsomeSliderIndicator.radius * 2) - 10
		
		ZStack(alignment: .center) {
			RoundedRectangle(cornerRadius: (height) / 2)
				.foregroundColor(helper.colorScheme.backgroundColor)
				.frame(height: height)
				.shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 0)
			HStack(spacing: 0) {
				ForEach(sliderObjects, id:\.self) { selectionable in
					Dot(newLocation: helper.getPosition(for: selectionable), sliderOffset: $sliderOffset)
						.foregroundColor(helper.colorScheme.stepColor)
					if selectionable != sliderObjects.last {
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

	let newLocation: Double
	@Binding var sliderOffset: Double
	
	var body: some View {
		Button {
			withAnimation(reduceMotion ? nil : .easeInOut) {
				sliderOffset = newLocation
			}
		} label: {
			Circle()
				.frame(width: 12, height: 12)
		}
	}
}
