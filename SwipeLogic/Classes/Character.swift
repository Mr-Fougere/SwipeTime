import Foundation

struct Coordinate: Hashable {
    var x: Int
    var y: Int
}

class Character :ObservableObject{
    let name: String
    @Published var healthPoints: Int
    @Published var currentHealthPoints: Int
    @Published var attack: Int
    @Published var defense: Int
    @Published var protection: Int
    @Published var timingBar: TimingBar?
    
    init(name: String, healthPoints: Int, attack: Int,defense: Int,protection:Int,timingBar: TimingBar) {
        self.name = name
        self.healthPoints = healthPoints
        self.attack = attack
        self.defense = defense
        self.protection = protection
        self.timingBar = timingBar
        self.currentHealthPoints = healthPoints
    }
}

class Hero: Character {
    @Published var gold: Int
    @Published var coordinate: Coordinate =  Coordinate(x: 0, y: 0)

    let swipeActions: [SwipeAction]

    
    init(name: String, 
        healthPoints: Int, 
        attack: Int,
        defense: Int,
        protection: Int,
        swipeActions: [SwipeAction], 
        timingBar: TimingBar,
        gold: Int,
        currentPositionX: Int,
        currentPositionY: Int) {
        self.gold = gold
        self.swipeActions = swipeActions
        super.init(name: name, healthPoints: healthPoints,attack: attack, defense: defense,protection: protection,timingBar: timingBar)
    }
}

class Monster: Character {
    var patternMoves: String
    var intervalMoves: [Float]
    var currentMove: Int
    var swipeEffects: [SwipeEffect]
    init(   name: String,
            healthPoints: Int, 
            attack: Int,
            defense: Int,
            protection: Int,
            timingBar: TimingBar,
            swipeEffects: [SwipeEffect],
            patternMoves: String,
            intervalMoves: [Float] ) {
        self.patternMoves = patternMoves
        self.intervalMoves = intervalMoves
        self.swipeEffects = swipeEffects
        self.currentMove = 0
        super.init(name: name, healthPoints: healthPoints, attack: attack,defense: defense,protection: protection, timingBar: timingBar)
    }
}
