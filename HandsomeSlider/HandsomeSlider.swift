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
	let colorScheme: HandsomeColorScheme
	
	init(selectionables: [SliderObject],
			 colorScheme: HandsomeColorScheme,
			 initialSelection: SliderObject? = nil) {
		self.colorScheme = colorScheme
		_selectionables = State(initialValue: selectionables)
		_currentSelection = State(initialValue: initialSelection ?? selectionables.first)
	}
	
	static let insidePadding: Double = 24
	
	var body: some View {
		GeometryReader { geometry in
			let width = geometry.size.width
			let selectionableHelper = SelectionableHelper(selectionables: selectionables, viewWidth: width)
			let notificationCenter = NotificationCenter.default
			let rotationNotification = UIDevice.orientationDidChangeNotification
			ZStack(alignment: .center) {
				HandsomeSliderBackground(helper: selectionableHelper, sliderOffset: $sliderOffset)
					.foregroundColor(colorScheme.backgroundColor)
				HandsomeSliderProductLabel(selectionable: currentSelection, sliderOffset: $sliderOffset)
				HandsomeSliderIndicator()
					.offset(x: sliderOffset)
					.tipSliderGesture(sliderOffset: $sliderOffset, helper: selectionableHelper)
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
