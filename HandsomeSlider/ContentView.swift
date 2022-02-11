//
//  ContentView.swift
//  HandsomeSlider
//
//  Created by Anton Martinsson on 2022-02-04.
//

import SwiftUI

struct ContentView: View {
	@State var selections = [SliderObject(id: UUID().uuidString, title: "Hej", subtitle: "då"),
													 SliderObject(id: UUID().uuidString, title: "Hejsan", subtitle: "svejsan"),
													 SliderObject(id: UUID().uuidString, title: "Mejsan", subtitle: "plejsan"),
													 SliderObject(id: UUID().uuidString, title: "Lejsan", subtitle: "blejsan")]
    var body: some View {
			HandsomeSlider(currentSelection: selections.first!, selectionables: $selections)
				.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
