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
	@Binding var selectionables: [SliderObject]

	func getSelectionable(for offset: Double, viewWidth: Double) -> SliderObject? {
		var possibleValues: [Double] = .empty
		for (index, _) in selectionables.enumerated() {
			let oneBasedIndex = index + 1
			let listCount = selectionables.count
			let sliderLocation = SliderObject.getLocation(for: oneBasedIndex, inListWithCount: listCount, viewWidth: viewWidth)
			possibleValues.append(sliderLocation)
		}
		
		guard let index = possibleValues.firstIndex(of: offset) else { return nil }
		return selectionables[index]
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .center) {
				HandsomeSliderBackground(selectionables: selectionables, viewWidth: geometry.size.width, sliderOffset: $sliderOffset)
				HandsomeSliderIndicator()
					.offset(x: sliderOffset)
					.tipSliderGesture(sliderOffset: $sliderOffset, selectionables: selectionables, viewWidth: geometry.size.width)
				HandsomeSliderProductLabel(selectionable: currentSelection, sliderOffset: $sliderOffset)
			}
			.onAppear(perform: {
				let count = selectionables.count
				let viewWidth = geometry.size.width
				sliderOffset = SliderObject.getLocation(for: 0, inListWithCount: count, viewWidth: viewWidth) + 25
			})
			.onChange(of: sliderOffset) { newValue in
				withAnimation(reduceMotion ? nil : .easeInOut) {
					guard let newSelection = getSelectionable(for: newValue, viewWidth: geometry.size.width) else {
						currentSelection = nil
						return
					}
					currentSelection = newSelection
				}
			}
		}
	}
}
