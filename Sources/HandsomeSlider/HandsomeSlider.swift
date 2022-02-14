//
//  Slider.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-09.
//

import SwiftUI
import StoreKit

public struct HandsomeSlider: View {
	@Environment(\.accessibilityReduceMotion) var reduceMotion

	@State private var sliderOffset: Double = 0
	@State private var sliderObjects: [SliderObject]
	@Binding private var currentSelection: SliderObject?
	private let colorScheme: HandsomeColorScheme
		
	static let insidePadding: Double = 16
	
	public init(sliderObjects: [SliderObject], initialSelection: Binding<SliderObject?>, colorScheme: HandsomeColorScheme = HandsomeColorScheme.defaultScheme) {
		self.sliderObjects = sliderObjects
		self.colorScheme = colorScheme
		_currentSelection = initialSelection
	}
	
	public var body: some View {
		GeometryReader { geometry in
			let width = geometry.size.width
			let notificationCenter = NotificationCenter.default
			let rotationNotification = UIDevice.orientationDidChangeNotification
			let selectionableHelper = SelectionableHelper(sliderObjects: sliderObjects,
																										viewWidth: width,
																										colorScheme: colorScheme)
			
			ZStack(alignment: .center) {
				HandsomeSliderBackground(helper: selectionableHelper,
																 sliderOffset: $sliderOffset)
				HandsomeSliderIndicator(sliderOffset: $sliderOffset,
																selectionable: $currentSelection,
																helper: selectionableHelper)
			}
			.onAppear(perform: {
				guard let initialSelection = currentSelection else { return }
				sliderOffset = selectionableHelper.getPosition(for: initialSelection)
			})
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
