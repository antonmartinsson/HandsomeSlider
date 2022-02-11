//
//  HandsomeSliderBackground.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI

struct HandsomeSliderBackground: View {
	let selectionables: [SliderObject]
	let viewWidth: CGFloat
	@Binding var sliderOffset: CGFloat

	var body: some View {
		ZStack(alignment: .center) {
			RoundedRectangle(cornerRadius: (50 - 5) / 2)
				.frame(height: 50 - 5)
				.foregroundColor(.accentColor.opacity(0.2))
				.shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 0)
			HStack(spacing: 0) {
				ForEach(1...selectionables.count, id:\.self) { index in
					let count = selectionables.count
					let newLocation = SliderObject.getLocation(for: index, inListWithCount: count, viewWidth: viewWidth)
					if index == 1 {
						Spacer()
					}
					Dot(newLocation: newLocation, sliderOffset: $sliderOffset)
					Spacer()
				}
			}
		}
	}
}

struct Dot: View {
	@Environment(\.accessibilityReduceMotion) var reduceMotion

	let newLocation: CGFloat
	@Binding var sliderOffset: CGFloat
	
	var body: some View {
		Button {
			withAnimation(reduceMotion ? nil : .easeInOut) {
				sliderOffset = newLocation
			}
		} label: {
			Circle()
				.frame(width: 12, height: 12)
				.foregroundColor(.white)
		}
	}
}
