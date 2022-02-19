//
//  Slider.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-09.
//

import SwiftUI
import StoreKit

/// A horizontal slider with a set number of options to choose from.
public struct HandsomeSlider: View {
	@Environment(\.accessibilityReduceMotion) var reduceMotion
	
	@State private var sliderOffset: Double = 0
	@State private var sliderOptions: [SliderOption]
	@Binding private var currentSelection: SliderOption?
	private let colorScheme: HandsomeColorScheme
	
	static let insidePadding: Double = 16
	
	/**
	 Initializes a slider with an a set number of options, an initial selection and a color scheme (which will default to a pre-defined colorScheme if not supplied).
	 
	 - Parameters:
			- sliderOptions: A list of options the user should be able to choose from using the slider.
			- initialSelection: The slider option that should be preselected when the slider is presented.
			- colorScheme: The `HandsomeColorScheme` that the slider should color itself according to.
	 */
	public init(sliderOptions: [SliderOption], initialSelection: Binding<SliderOption?>, colorScheme: HandsomeColorScheme = HandsomeColorScheme.defaultScheme) {
		self.sliderOptions = sliderOptions
		self.colorScheme = colorScheme
		_currentSelection = initialSelection
	}
	
	public var body: some View {
		GeometryReader { geometry in
			let width = geometry.size.width
			let notificationCenter = NotificationCenter.default
			let rotationNotification = UIDevice.orientationDidChangeNotification
			let viewModel = SliderViewModel(sliderOptions: sliderOptions,
																			viewWidth: width,
																			colorScheme: colorScheme)
			
			ZStack(alignment: .center) {
				HandsomeSliderBackground(viewModel: viewModel,
																 sliderOffset: $sliderOffset)
				HandsomeSliderIndicator(sliderOffset: $sliderOffset,
																sliderOption: $currentSelection,
																viewModel: viewModel)
			}
			.onAppear(perform: {
				guard let initialSelection = currentSelection else { return }
				sliderOffset = viewModel.getPosition(for: initialSelection)
			})
			.onReceive(notificationCenter.publisher(for: rotationNotification), perform: { _ in
				if let currentSelection = currentSelection {
					let newPosition = viewModel.getPosition(for: currentSelection)
					sliderOffset = newPosition
				} else {
					currentSelection = sliderOptions.first
					sliderOffset = viewModel.firstPosition
				}
			})
			.onChange(of: sliderOffset) { newValue in
				withAnimation(reduceMotion ? nil : .easeInOut) {
					guard let newSelection = viewModel.getSelectionable(for: newValue) else {
						currentSelection = nil
						return
					}
					currentSelection = newSelection
				}
			}
		}
		.frame(maxHeight: HandsomeSliderIndicator.radius * 2 + 65)
	}
}
