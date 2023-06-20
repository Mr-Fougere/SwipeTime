import Foundation

enum BattleResult :String {
    case win
    case lose
    case in_progress
}

class Battle : ObservableObject{
    
    @Published var hero: Hero
    @Published var monsters: [Monster]
    let reward: [SwipeAction]
    
    init(hero: Hero, monsters: [Monster], reward: [SwipeAction]) {
        self.hero = hero
        self.monsters = monsters
        self.reward = reward
    }
    
    func generateBindingKey() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let keyLength = 10
        var randomKey = ""

        for _ in 0..<keyLength {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomKey.append(character)
        }

        return randomKey
    }
    
    func startBattle(){
        print("begin")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            self.generateAction()
        }
    }
    
    func generateAction(){
        let currentMonster: Monster = monsters[0]
        let indexMove: Int = currentMonster.currentMove
        let patterns = currentMonster.patternMoves
        let currentPattern: Swift.Character = patterns[patterns.index(patterns.startIndex,offsetBy: indexMove)];
        let currentInterval: Float = currentMonster.intervalMoves[indexMove]
        let bindingKey: String = generateBindingKey()
        let currentSwipeEffect: SwipeEffect? =  getSwipeEffect(character: currentPattern, swipeEffects: currentMonster.swipeEffects)
        if currentSwipeEffect != nil {
            let monsterAction: Action = Action(timing: 100, swipeEffect: currentSwipeEffect , owner: currentMonster, bindingKey: bindingKey)
            let heroAction: Action = Action(timing: 100, swipeEffect: nil , owner: self.hero , bindingKey: bindingKey)
            self.monsters[0].timingBar?.actions.append(monsterAction)
            self.hero.timingBar?.actions.append(heroAction)
        }
        
        if indexMove == 19 {
            self.monsters[0].currentMove = 0
        }else{
            self.monsters[0].currentMove += 1
        }
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(currentInterval), repeats: false) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            print(currentMonster.currentHealthPoints)
            if currentMonster.currentHealthPoints <= 0 || self.hero.currentHealthPoints <= 0{
                timer.invalidate()
                return
            }
            self.generateAction()
        }
        objectWillChange.send()
    }
    
    func getSwipeEffect(character: Swift.Character,swipeEffects: [SwipeEffect]) -> SwipeEffect? {
        var searchedType: ActionType = .attack
        switch character {
            case "U":
                searchedType = .special
            case "L":
                searchedType = .attack
            case "R":
                searchedType = .defense
            case "D":
                searchedType = .other
            default:
                searchedType = .attack
            }
        let foundedEffect : [SwipeEffect] = swipeEffects.filter{$0.type != searchedType}
        
        if foundedEffect.count > 0 {
            return foundedEffect[0]
        }
        return nil
        
    }

}
