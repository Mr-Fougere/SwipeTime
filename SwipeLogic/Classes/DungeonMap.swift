import Foundation
import SwiftUI



enum CellType: CaseIterable, CustomStringConvertible {
    case battle
    case market
    case boss
    case camp
    case empty
    case other
    case depart
    case path 

    var description: String {
        return getImageName()
    }
    
    func getImageName() -> String {
        switch self {
        case .battle: return "Battle"
        case .market: return "market"
        case .boss: return "Boss"
        case .camp: return "camp"
        case .empty: return "emptyImage"
        case .other: return "aléatoire"
        case .depart: return "depart"
        case .path: return "joueur"
        }
    }
    
    func getImage() -> Image {
        return Image(getImageName())
    }
}

extension CellType {
    static var random: CellType {
        return CellType.allCases.filter { $0 != .depart && $0 != .path }.randomElement()!
    }
    
    static var randomForPath: CellType {
        return CellType.allCases.filter { $0 != .depart && $0 != .path }.randomElement()!
    }
}

class Cell: Equatable, Hashable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.coordinate == rhs.coordinate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinate)
    }
    
    var coordinate: Coordinate
    var type: CellType
    var clear: Bool // Indicates if the cell is clear for the player to move onto

    init(coordinate: Coordinate, type: CellType, clear: Bool) {
        self.coordinate = coordinate
        self.type = type
        self.clear = clear
    }
}



class DungeonMap: ObservableObject {
    @Published var map: [[Cell?]] = []
    @Published var path: [Cell] = [] // this will hold the path cells
    @Published var hero: Hero // This will hold the player

    let name: MapName
    let width: Int
    let height: Int
    let level: Int
    var color: UIColor {
        switch self.name {
        case .fireKingdom:
            return .orange
        case .iceKingdom:
            return .blue
        case .candyKingdom:
            return .systemPink
        case .nightosphere:
            return .black
        case .forest:
            return .systemGreen
        case .lumpySpace:
            return .purple
        }
    }

    
    init(name: MapName, level: Int, width: Int, height: Int, hero: Hero) {
        // Place the player at the start by default
        self.name = name
        self.level = level
        self.width = width
        self.hero = hero
        self.height = height
        for x in 0..<10 {
            var row: [Cell?] = []
            for y in 0..<10 {
                let coordinate = Coordinate(x: x, y: y)
                var cellType: CellType
                
                if x == 0 && y == 0 {
                    cellType = .depart
                } else {
                    cellType = CellType.random
                }
                
                row.append(Cell(coordinate: coordinate, type: cellType, clear: false))
            }
            map.append(row)
        }
        
        generatePath(from: Coordinate(x: 0, y: 0), to: Coordinate(x: 9, y: 9))
    }

    func getCell(at coordinate: Coordinate) -> Cell? {
        guard coordinate.x >= 0, coordinate.x < 10, coordinate.y >= 0, coordinate.y < 10 else {
            return nil
        }
        return map[coordinate.x][coordinate.y]
    }
    
    func displayPath() {
        for cell in path {
            print("Cell at (\(cell.coordinate.x), \(cell.coordinate.y)) is of type \(cell.type)")
        }
    }
    
    func generatePath(from start: Coordinate, to end: Coordinate) {
        var currentPos = start
        // Add the start cell to the path
        let startCell = getCell(at: currentPos)!
        path.append(startCell)
        // Start moving from the cell after departure
        if Bool.random() {
            currentPos.x += 1
        } else {
            currentPos.y += 1
        }
        
        while currentPos != end {
            let cell = getCell(at: currentPos)!
            cell.type = CellType.randomForPath
            cell.clear = false // Set clear to true for the path cells
            path.append(cell) // add cell to path
            
            // randomly move right or up
            if Bool.random() {
                currentPos.x += 1
            } else {
                currentPos.y += 1
            }
            
            // ensure we don't go out of bounds
            currentPos.x = min(currentPos.x, 9)
            currentPos.y = min(currentPos.y, 9)
        }
        
        // set the end cell to be a random type too
        let endCell = getCell(at: end)!
        endCell.type = CellType.randomForPath
        endCell.clear = false // Set clear to true for the end cell
        path.append(endCell) // add end cell to path
    }
    
    func placePlayerAtStart() {
        hero.coordinate = Coordinate(x: 0, y: 0)
    }
    
    func movePlayerUp() {
        let oldCoordinate = hero.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: hero.coordinate.x, y: hero.coordinate.y - 1)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            hero.coordinate = newCoordinate
            print("New position: (\(newCoordinate.x), \(newCoordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
        
    }
    
    func movePlayerDown() {
        let oldCoordinate = hero.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: hero.coordinate.x, y: hero.coordinate.y + 1)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            hero.coordinate = newCoordinate
            print("New position: (\(newCoordinate.x), \(newCoordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
    }
    
    func movePlayerLeft() {
        let oldCoordinate = hero.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: hero.coordinate.x - 1, y: hero.coordinate.y)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            hero.coordinate = newCoordinate
            print("New position: (\(newCoordinate.x), \(newCoordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
    }
    
    func movePlayerRight() {
        let oldCoordinate = hero.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: hero.coordinate.x + 1, y: hero.coordinate.y)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            hero.coordinate = newCoordinate
            print("New position: (\(hero.coordinate.x), \(hero.coordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
    }
}
