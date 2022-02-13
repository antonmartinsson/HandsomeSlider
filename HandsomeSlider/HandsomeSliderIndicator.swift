//
//  HandsomeSliderIndicator.swift
//  Cryptoverview
//
//  Created by Anton Martinsson on 2022-01-15.
//

import SwiftUI
import StoreKit

struct HandsomeSliderIndicator: View {
	
	static let sliderRadius: Double = 25
	
	var body: some View {
		let size = HandsomeSliderIndicator.sliderRadius * 2
		
		ZStack {
			Circle()
				.frame(width: size, height: size)
				.foregroundColor(.accentColor)
		}
	}
}
