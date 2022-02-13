//
//  ContentView.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-04.
//

import SwiftUI

struct ContentView: View {
	let selection1 = SliderObject(id: UUID().uuidString, title: "Hej", subtitle: "då")
	let selection2 = SliderObject(id: UUID().uuidString, title: "Hejsan", subtitle: "svejsan")
	let selection3 = SliderObject(id: UUID().uuidString, title: "Mejsan", subtitle: "plejsan")
	let selection4 = SliderObject(id: UUID().uuidString, title: "Lejsan", subtitle: "blejsan")
	
	var body: some View {
		let colorScheme = HandsomeColorScheme.defaultScheme
		let selections = [selection1,
											selection2,
											selection3,
											selection4]
		
		HandsomeSlider(selectionables: selections, colorScheme: colorScheme)
			.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
