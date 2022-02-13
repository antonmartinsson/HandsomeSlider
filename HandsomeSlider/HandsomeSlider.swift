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

	@State private var sliderOffset: Double = 0
	@State var selectionables: [SliderObject]
	@Binding var currentSelection: SliderObject?
	let colorScheme: HandsomeColorScheme
		
	static let insidePadding: Double = 16
	
	var body: some View {
		GeometryReader { geometry in
			let width = geometry.size.width
			let notificationCenter = NotificationCenter.default
			let rotationNotification = UIDevice.orientationDidChangeNotification
			let selectionableHelper = SelectionableHelper(selectionables: selectionables,
																										viewWidth: width,
																										colorScheme: colorScheme)
			
			ZStack(alignment: .center) {
				HandsomeSliderBackground(helper: selectionableHelper,
																 sliderOffset: $sliderOffset)
				HandsomeSliderIndicator(sliderOffset: $sliderOffset,
																selectionable: $currentSelection,
																helper: selectionableHelper)
			}
			.task {
				guard let initialSelection = currentSelection else { return }
				sliderOffset = selectionableHelper.getPosition(for: initialSelection)
			}
			.onReceive(notificationCenter.publisher(for: rotationNotification), perform: { _ in
				guard let currentSelection = currentSelection else { return }
				let newPosition = selectionableHelper.getPosition(for: currentSelection)
				sliderOffset = newPosition
			})
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
