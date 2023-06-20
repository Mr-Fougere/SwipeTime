//
//  SwipeEffect.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import Foundation


enum Target{
    case you
    case opponent
}

enum CharacterStat{
    case healthPointss
    case attack
    case combo
    case defense
    case protection
    case perfectTiming
    case greatTiming
    case goodTiming
    case missTiming
    case one
}

class SwipeEffect:Hashable, Equatable {
    let target: Target
    let affectedStat: CharacterStat
    let referenceStat: CharacterStat
    let value: Int
    let type: ActionType

    init(target: Target,type: ActionType, affectedStat: CharacterStat,referenceStat: CharacterStat, value: Int) {
        self.type = type
        self.target = target
        self.affectedStat = affectedStat
        self.referenceStat = referenceStat
        self.value = value
    }
    
    
    func updateAction(mulitplier: Int,battle: Battle){
        if let lastAction = battle.hero.timingBar?.actions.first {
            let result = battle.hero.timingBar?.getTimingResult(time: lastAction.timing)
            lastAction.result = result!
            lastAction.swipeEffect = self
        }
    }
    
    static func == (lhs: SwipeEffect, rhs: SwipeEffect) -> Bool {
            return lhs.target == rhs.target &&
                lhs.affectedStat == rhs.affectedStat &&
                lhs.referenceStat == rhs.referenceStat &&
                lhs.value == rhs.value
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(target)
            hasher.combine(affectedStat)
            hasher.combine(referenceStat)
            hasher.combine(value)
        }
    
    
    
}
