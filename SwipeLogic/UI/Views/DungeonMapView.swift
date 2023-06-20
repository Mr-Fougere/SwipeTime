//
//  DungeonMapView.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 20/06/2023.
//

import SwiftUI

struct DungeonView: View {
    let donjonMap = AppState.shared.adventure?.currentDungeon
    init() {
        donjonMap!.displayPath()
    }
    
    var body: some View {
        VStack {
            DungeonMapView(donjonMap: donjonMap!)
        }
        .padding()
    }
}

