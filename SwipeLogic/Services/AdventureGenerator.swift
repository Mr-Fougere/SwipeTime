//
//  DungeonGenerator.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import Foundation

class AdventureGenerator{
    
    let hero: Hero
    let dungeonMap: DungeonMap
    let difficulty: Difficulty
    
    init() {
        self.hero = Basics().basicHero()
        self.difficulty = AppState.shared.difficulty
        self.dungeonMap = DungeonMap(name: .forest, dungeonCases: [], level: 1, width: 10, height: 10)
    }
    
    func perform() -> Adventure {
        return Adventure(difficulty: difficulty, hero: hero, currentDungeon: dungeonMap)
    }
}
