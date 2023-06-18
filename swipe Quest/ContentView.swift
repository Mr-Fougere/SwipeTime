//
//  ContentView.swift
//  swipe Quest
//
//  Created by ipourou on 14/06/2023.
//

import SwiftUI

struct ContentView: View {
    let donjonMap = DonjonMap()
    init() {
        donjonMap.displayPath()
    }
    
    var body: some View {
        VStack {
            DungeonMapView(donjonMap: donjonMap)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
