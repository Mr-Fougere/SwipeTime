enum EventType {
    case battle
    case boss
    case camp
    case unknown
    case market
    case empty
}

enum MapName {
    case fireKingdom
    case iceKingdom
    case candyKingdom
    case nightosphere
    case forest
    case lumpySpace
}


class DungeonCase {
    let positionX: Int
    let positionY: Int
    let event: EventType
    let hideEvent: Bool
    let clear: Bool

    
    init(positionX: Int, positionY: Int, event: String, hideEvent: Bool,clear: Bool) {
        self.positionX = positionX
        self.positionY = positionY
        self.event = event
        self.clear = clear
        self.hideEvent = hideEvent
    }
}

class DungeonMap {
    let name: MapName
    let width: Int
    let height: Int
    let dungeonCases: [DungeonCase]
    let level: Int
    let color: String
    
    init(name: MapName, dungeonCases: [DungeonCase], level: Int,width: Int,height: Int)
        self.name = name
        self.dungeonCases = dungeonCases
        self.level = level
        self.width = width
        self.height = height
        setMapColor()
    }

    func setMapColor(){
        switch self.name {
        case .fireKingdom:
            self.color = "orange"
        case .iceKingdom:
            self.color = "blue"
        case .candyKingdom:
            self.color = "pink"
        case .nightosphere:
            self.color = "black"
        case .forest:
            self.color = "green"
        case .lumpySpace:
            self.color = "purple"
    }
}


