//
//  SwipeLogicApp.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import SwiftUI

@main
struct SwipeLogicApp: App {
    
    @ObservedObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            switch appState.userState {
            case .splashScreen:
                SplashScreenView()
            case .inMenu,.selectDifficulty,.selectOption:
                MenuView()
            case .generatingDungeon:
                GeneratinScreenView()
            case .onDungeonMap:
                DungeonView()
            case .inBattle,.inBoss:
                BattleView()
            case .inMarket:
                MarketView()
            default:
                EmptyView()
            }
        }
    }
}
