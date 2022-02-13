//
//  ContentView.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-04.
//

import SwiftUI

struct ContentView: View {
	@State var objects: [SliderObject]
	@State var selectedObject: SliderObject?
	
	var body: some View {
		let colorScheme = HandsomeColorScheme.defaultScheme
		
		HandsomeSlider(selectionables: objects,
									 currentSelection: $selectedObject,
									 colorScheme: colorScheme)
			.padding(24)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let selection1 = SliderObject(id: UUID().uuidString, title: "Hej", subtitle: "då")
		let selection2 = SliderObject(id: UUID().uuidString, title: "Hejsan", subtitle: "svejsan")
		let selection3 = SliderObject(id: UUID().uuidString, title: "Mejsan", subtitle: "plejsan")
		let selection4 = SliderObject(id: UUID().uuidString, title: "Lejsan", subtitle: "blejsan")
		let objects = [selection1, selection2, selection3, selection4]
		ContentView(objects: objects, selectedObject: selection1)
	} 
}
