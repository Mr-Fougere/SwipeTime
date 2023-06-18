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

class SwipeEffect {
    let target: Target
    let affectedStat: CharacterStat
    let referenceStat: CharacterStat
    let value: Int
    
    init(target: Target, affectedStat: CharacterStat,referenceStat: CharacterStat, value: Int) {
        self.target = target
        self.affectedStat = affectedStat
        self.referenceStat = referenceStat
        self.value = value
    }
    
    
    func applyEffect(mulitplier: Int){
        
    }
    
}
