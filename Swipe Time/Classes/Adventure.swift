enum Difficulty {
    case easy
    case medium
    case hard
}

class Adventure {
    let difficulty: Difficulty
    let hero: Hero
    let currentDungeon: DungeonMap
    
    init(difficulty: Difficulty, hero: Hero, currentDungeon: DungeonMap) {
        self.difficulty = difficulty
        self.hero = hero
        self.currentDungeon = currentDungeon
    }
}
