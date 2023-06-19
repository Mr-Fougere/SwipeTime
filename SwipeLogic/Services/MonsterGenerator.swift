//
//  DungeonGenerator.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import Foundation

class MonsterGenerator{
    
    let difficulty: Difficulty
    
    init() {
        self.difficulty = AppState.shared.adventure?.difficulty ?? .easy
    }
    
    func generateEnemy(difficulty: Difficulty) -> Monster? {
        var enemyHealth = 0
        var enemyDamage = 0
        var enemyDefense = 0

        switch self.difficulty {
        case .easy:
            enemyHealth = 50
            enemyDamage = 5
            enemyDefense = 5
        case .medium:
            enemyHealth = 100
            enemyDamage = 10
            enemyDefense  = 10
        case .hard:
            enemyHealth = 150
            enemyDamage = 30
        case .not_selected:
            enemyHealth = 0
            enemyDamage = 0
        }

        let (movementPattern, movementDurations) = generateRandomMovementPattern()
        return  Monster(name: randomName(), healthPoints: enemyHealth, attack: enemyDamage, defense: enemyDefense, protection: 0, timingBar: Basics().basicTimingBar(), swipeEffects: [Basics().basicAtackEffect,Basics().basicDefenseEffect,Basics().enemySpecialEffect], patternMoves: movementPattern, intervalMoves: movementDurations )
    }
    
    func randomName(){
        
    }
    
    func generateRandomMovementPattern() -> (String, [Float]) {
        let possibleMoves = ["U", "D", "R", "L"]
        let possibleDurations: [Float] = [0.5, 1, 1.5, 2] // Exemple de tableau de valeurs en secondes pour chaque mouvement
        var movementPattern = ""
        var durations: [Float] = []

        for _ in 0..<20 {
            let randomMoveIndex = Int.random(in: 0..<possibleMoves.count)
            let randomMove = possibleMoves[randomMoveIndex]
            
            let randomDurationIndex = Int.random(in: 0..<possibleDurations.count)
            let randomDuration = possibleDurations[randomDurationIndex]
        
            movementPattern += randomMove
            durations.append(randomDuration)
        }
        return (movementPattern, durations)
    }
    
    func randomName() -> String {
        let nouns = ["Penguin"]

        let randomNounIndex = Int.random(in: 0..<nouns.count)

        let randomNoun = nouns[randomNounIndex]

        return randomNoun
    }

}
