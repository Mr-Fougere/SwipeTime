//
//  BattleGenerator.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import Foundation


class BattleGenerator{
    
    let adventure: Adventure
    
    init() {
        self.adventure = AppState.shared.adventure!
    }
    
    func perform()-> Battle{
        return Battle(hero: adventure.hero, monsters: generateMonsters(), reward: [SwipeEffects().exit])
    }
    
    func generateMonsters()-> [Monster]{
        var monsters: [Monster] = []
        for _ in 0..<adventure.currentDungeon.level {
            monsters.append(MonsterGenerator().generateEnemy(difficulty: adventure.difficulty)!)
        }
        return monsters
    }
}
