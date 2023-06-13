enum MapName {
    case fireKingdom
    case iceKingdom
    case candyKingdom
    case nightosphere
    case forest
    case lumpySpace
}

class DungeonMap {
    var name: MapName
    var dungeonCases: [DungeonCase]
    var level: Int
    
    init(name: MapName, dungeonCases: [DungeonCase], level: Int) {
        self.name = name
        self.dungeonCases = dungeonCases
        self.level = level
    }
}
