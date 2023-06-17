//
//  SwitchAction.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import Foundation
import SwiftUI

enum UserState {
    case splashScreen
    case inMenu
    case selectDifficulty
    case selectOption
    case generatingDungeon
    case onDungeonMap
    case inBattle
    case inMarket
    case inCamp
    case inBoss
    case inTreasure
    case inEvent
}

enum Difficulty {
    case easy
    case medium
    case hard
    case not_selected
}

enum Language {
    case french
    case english
    case japanese
}

import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var userState: UserState = .splashScreen
    @Published var difficulty: Difficulty = .not_selected
    @Published var language: Language = .french

}

