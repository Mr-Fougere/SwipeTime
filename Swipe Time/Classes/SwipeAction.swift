enum ActionType {
    case attack
    case defense
    case special
}

enum TargetType {
    case you
    case opponent
}

enum StatAffected {
    case healthPoints
    case attack
}

class SwipeAction {
    let type: ActionType
    let target: TargetType
    let statAffected: StatAffected
    let value: Int
    
    init(type: ActionType, target: TargetType, statAffected: StatAffected, value: Int) {
        self.type = type
        self.target = target
        self.statAffected = statAffected
        self.value = value
    }
}

