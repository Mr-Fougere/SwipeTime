import Foundation

class Hero {
    var name: String
    var health: Int
    var damage: Int

    init(name: String, health: Int, damage: Int) {
        self.name = name
        self.health = health
        self.damage = damage
    }

    func takeDamage(damage: Int) {
        health -= damage
        if health < 0 {
            health = 0
        }
    }
}


class Enemy {
    var name: String
    var health: Int
    var damage: Int
    var movementPattern: String
    var movementDurations: [Float]

    init(name: String, health: Int, damage: Int, movementPattern: String, movementDurations: [Float]) {
        self.name = name
        self.health = health
        self.damage = damage
        self.movementPattern = movementPattern
        self.movementDurations = movementDurations
    }

    func takeDamage(damage: Int) {
        health -= damage
        if health < 0 {
            health = 0
        }
    }
}

enum Difficulty {
    case facile
    case moyen
    case difficile
}

func generateEnemy(difficulty: Difficulty) -> Enemy? {
    var enemy: Enemy?
    var enemyHealth = 0
    var enemyDamage = 0

    switch difficulty {
    case .facile:
        enemyHealth = 50
        enemyDamage = 10
    case .moyen:
        enemyHealth = 100
        enemyDamage = 20
    case .difficile:
        enemyHealth = 150
        enemyDamage = 30
    }

    let randomName = generateRandomName()
    let (movementPattern, movementDurations) = generateRandomMovementPattern()

    enemy = Enemy(name: randomName, health: enemyHealth, damage: enemyDamage, movementPattern: movementPattern, movementDurations: movementDurations)

    return enemy
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





func generateRandomName() -> String {
    let nouns = ["BadTiro", "DancingSnail", "Dogi", "MicroWaveBot", "MisterHeart", "MouseThief", "Pingi", "RedDevil", "SandWishDevil", "YelloDevil"]

    let randomNounIndex = Int.random(in: 0..<nouns.count)

    let randomNoun = nouns[randomNounIndex]

    return randomNoun
}

let hero = Hero(name: "FINN", health: 100, damage: 5)

let difficulty = Difficulty.moyen
if let enemy = generateEnemy(difficulty: difficulty) {
    // Utilisez l'objet enemy généré
    print("Un ennemi nommé \(enemy.name) a été créé avec une santé de \(enemy.health) et inflige \(enemy.damage) dégâts.")
    print("Pattern de mouvement : \(enemy.movementPattern)")
    print("Durées : \(enemy.movementDurations)")

    while hero.health > 0 && enemy.health > 0 {
        print("Le héros \(hero.name) attaque l'ennemi.")
        enemy.takeDamage(damage: hero.damage)
        print("Nouveau niveau de vie de l'ennemi après les dégâts : \(enemy.health)")

        if enemy.health <= 0 {
            print("Le héros \(hero.name) a vaincu l'ennemi \(enemy.name) !")
            break
        }

        print("L'ennemi contre-attaque le héros.")
        hero.takeDamage(damage: enemy.damage)
        print("Nouveau niveau de vie du héros après les dégâts : \(hero.health)")

        if hero.health <= 0 {
            print("L'ennemi \(enemy.name) a vaincu le héros \(hero.name) !")
            break
        }
    }
} else {
    print("Niveau de difficulté invalide.")
}





