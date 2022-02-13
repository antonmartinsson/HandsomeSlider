//
//  Slider.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-09.
//

import SwiftUI
import StoreKit

struct HandsomeSlider: View {
	@Environment(\.accessibilityReduceMotion) var reduceMotion

	@State private var sliderOffset: CGFloat = 0
	@State var currentSelection: SliderObject?
	@State var selectionables: [SliderObject]
	
	static let insidePadding: Double = 24
	
	var body: some View {
		GeometryReader { geometry in
			let width = geometry.size.width
			let selectionableHelper = SelectionableHelper(selectionables: selectionables, viewWidth: width)
			
			ZStack(alignment: .center) {
				HandsomeSliderBackground(helper: selectionableHelper, sliderOffset: $sliderOffset)
				HandsomeSliderIndicator()
					.offset(x: sliderOffset)
					.tipSliderGesture(sliderOffset: $sliderOffset, helper: selectionableHelper)
				HandsomeSliderProductLabel(selectionable: currentSelection, sliderOffset: $sliderOffset)
			}
			.task {
				guard let initialSelection = currentSelection else { return }
				sliderOffset = selectionableHelper.getPosition(for: initialSelection)
			}
			.onChange(of: sliderOffset) { newValue in
				withAnimation(reduceMotion ? nil : .easeInOut) {
					guard let newSelection = selectionableHelper.getSelectionable(for: newValue) else {
						currentSelection = nil
						return
					}
					currentSelection = newSelection
				}
			}
		}
	}
}
