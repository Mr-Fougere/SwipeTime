class Character {
    let name: String
    let healthPoints: Int
    let attack: Int
    let swipeActions: [SwipeAction]
    let timingBar: TimingBar?
    
    init(name: String, healthPoints: Int, attack: Int, swipeActions: [SwipeAction],timingBar: TimingBar) {
        self.name = name
        self.healthPoints = healthPoints
        self.attack = attack
        self.swipeActions = swipeActions
        self.timingBar = timingBar
    }
}

class Hero: Character {
    let gold: Int
    let currentPositionX: Int
    let currentPositionY: Int
    
    init(name: String, 
        healthPoints: Int, 
        attack: Int,
        swipeActions: [SwipeAction], 
        timingBar: TimingBar,
        gold: Int, 
        currentPositionX: Int, 
        currentPositionY: Int) {
        self.gold = gold
        self.currentPositionX = currentPositionX
        self.currentPositionY = currentPositionY
        super.init(name: name, healthPoints: healthPoints, attack: attack, swipeActions: swipeActions,timingBar: timingBar)
    }
}

class Monster: Character {
    var pattern: Any
    
    init(   name: String,
            healthPoints: Int, 
            attack: Int, 
            timingBar: TimingBar,
            swipeActions: [SwipeAction],
            pattern: Any) {
        self.pattern = pattern
        super.init(name: name, healthPoints: healthPoints, attack: attack, swipeActions: swipeActions, timingBar: timingBar)
    }
}
