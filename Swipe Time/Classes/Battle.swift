class Battle {
    let hero: Hero
    let monsters: [Monster]
    let reward: Any
    
    init(hero: Hero, monsters: [Monster], reward: Any) {
        self.hero = hero
        self.monsters = monsters
        self.reward = reward
    }
}

   
private func generateBindingKey() -> String {
    let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var randomString = ""
    
    for _ in 0..<10 {
        let randomIndex = Int.random(in: 0..<characters.count)
        let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
        randomString.append(randomCharacter)
    }
    
    return randomString
}

