//
//  HandsomeSliderBackground.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI

struct HandsomeSliderBackground: View {
	let helper: SelectionableHelper
	@Binding var sliderOffset: CGFloat

	var body: some View {
		let selectionables = helper.selectionables
		
		ZStack(alignment: .center) {
			RoundedRectangle(cornerRadius: (50 - 5) / 2)
				.frame(height: 50 - 5)
				.foregroundColor(.accentColor.opacity(0.2))
				.shadow(color: .orange.opacity(0.5), radius: 10, x: 0, y: 0)
			HStack(spacing: 0) {
				ForEach(selectionables, id:\.self) { selectionable in
					Dot(newLocation: helper.getPosition(for: selectionable), sliderOffset: $sliderOffset)
					if selectionable != selectionables.last {
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
