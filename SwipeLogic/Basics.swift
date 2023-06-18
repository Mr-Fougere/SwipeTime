//
//  Basics.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import Foundation

class Basics {
    
    
    public let basicAtackEffect: SwipeEffect = SwipeEffect(target: .opponent, affectedStat: .healthPointss, referenceStat: .attack, value: 1)
    
    public let basicDefenseEffect: SwipeEffect = SwipeEffect(target: .you, affectedStat: .protection, referenceStat: .defense, value: 1)
    
    public let enemySpecialEffect: SwipeEffect = SwipeEffect(target: .opponent, affectedStat: .defense, referenceStat: .one, value: 1)
    
    public lazy var basicSwipeAttack: SwipeAction = SwipeAction(type: .attack, image: "basic_sword", text: "Deal 1x attack") { param in self.basicAtackEffect.applyEffect(mulitplier: param)
    }

    public lazy var basicSwipeDefense: SwipeAction = SwipeAction(type: .defense, image: "basic_defense", text: "Protect 5 damage") {
        param in self.basicDefenseEffect.applyEffect(mulitplier: param)
    }
    
    public lazy var enemySwipeEffect: SwipeAction = SwipeAction(type: .special, image: "reduce_damage", text: "Reduce opponent atk by 1") {
        param in self.enemySpecialEffect.applyEffect(mulitplier: param)
    }

    func basicHeroSwipeActions() -> [SwipeAction]{
        return [basicSwipeAttack,basicSwipeDefense]
    }
    
    func basicMonsterSwipeActions() -> [SwipeAction]{
        return [basicSwipeAttack,basicSwipeDefense,enemySwipeEffect]
    }

    func basicHero() -> Hero {
        return Hero(name: "Finn", healthPoints: 100, attack: 5,defense: 5,protection: 0, swipeActions: basicHeroSwipeActions(), timingBar: basicTimingBar(), gold: 0, currentPositionX: 0, currentPositionY: 0)
    }
    
    func basicTimingBar()-> TimingBar{
        return TimingBar(perfectTiming: 5, greatTiming: 10, goodTiming: 20, combo: 0)
    }
    
    func emptySwipeAction()->SwipeAction{
        return SwipeAction(type: .other, image: "No action", text: "No action") {_ in 
            print("No action")
        }
    }
}

