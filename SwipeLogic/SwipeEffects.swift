//
//  Basics.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import Foundation

class SwipeEffects {
    
    public lazy var exit: SwipeAction = SwipeAction(type: .other, image: "exit", text: "Go") {
        param in AppState.shared.userState = .onDungeonMap
    }

}

