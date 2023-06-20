//
//  Basics.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import Foundation

class Basics {
    
    
    public let basicAtackEffect: SwipeEffect = SwipeEffect(target: .opponent,type: .attack, affectedStat: .healthPointss, referenceStat: .attack, value: -1)
    
    public let basicDefenseEffect: SwipeEffect = SwipeEffect(target: .you,type: .defense, affectedStat: .protection, referenceStat: .defense, value: +1)
    
    public let enemySpecialEffect: SwipeEffect = SwipeEffect(target: .opponent,type: .special, affectedStat: .defense, referenceStat: .one, value: -1)
    
    public lazy var basicSwipeAttack: SwipeAction = SwipeAction(type: .attack, image: "basic_sword", text: "Attack") { param in self.basicAtackEffect.updateAction(mulitplier: param, battle: AppState.shared.battle!)
    }

    public lazy var basicSwipeDefense: SwipeAction = SwipeAction(type: .defense, image: "basic_shield", text: "Protect") {
        param in self.basicDefenseEffect.updateAction(mulitplier: param,battle: AppState.shared.battle!)
    }
    
    public lazy var enemySwipeEffect: SwipeAction = SwipeAction(type: .special, image: "reduce_damage", text: "Reduce opponent atk by 1") {
        param in self.enemySpecialEffect.updateAction(mulitplier: param,battle: AppState.shared.battle!)
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
    
    func emptySpecial()->SwipeAction{
        return SwipeAction(type: .other, image: "no_special", text: "") {_ in
            print("No action")
        }
    }
    
    func emptyOther()->SwipeAction{
        return SwipeAction(type: .other, image: "no_other", text: "") {_ in
            print("No action")
        }
    }
    
    func emptySwipeAction()->SwipeAction{
        return SwipeAction(type: .other, image: "no_action", text: "") {_ in
            print("No action")
        }
    }
}

