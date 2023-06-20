//
//  RewardGenerator.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 20/06/2023.
//

import Foundation

class RewardGenerator{
    
    
    let hero: Hero
    let result: BattleResult
    let appState = AppState.shared
    
    
    init(hero : Hero,result: BattleResult) {
        self.hero = hero
        self.result = result
    }
    
    func perform() -> SwipePad {
        var downAction: SwipeAction
        var leftAction: SwipeAction
        var upAction: SwipeAction
        var rightAction: SwipeAction
        if self.result == .win {
            downAction = SwipeAction(type: .other, image: "return", text: "Go", action: {_ in self.appState.battle = nil;self.appState.userState = .onDungeonMap })
            leftAction = SwipeAction(type: .other, image: "gold", text: "+100 Gold", action: {_ in self.appState.adventure?.hero.gold += 100 })
            upAction  = SwipeAction(type: .other, image: "no_action_h", text: "", action: {_ in })
            rightAction = SwipeAction(type: .other, image: "no_action_v", text: "", action: {_ in  })

        }else {
            downAction = SwipeAction(type: .other, image: "back", text: "Quit", action: {_ in self.appState.userState = .inMenu })
            leftAction = SwipeAction(type: .other, image: "no_action_v", text: "", action: {_ in })
            upAction = SwipeAction(type: .other, image: "newAdventure", text: "Retry", action: {_ in self.appState.battle = nil; self.appState.userState = .generatingDungeon})
            rightAction = SwipeAction(type: .other, image: "no_action_v", text: "", action: {_ in  })
        }
        return SwipePad(rightAction: rightAction, leftAction: leftAction, upAction: upAction, downAction: downAction)
    }
}
