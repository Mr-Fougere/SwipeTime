import Foundation
import SwiftUI

struct Coordinate: Hashable {
    var x: Int
    var y: Int
}

enum CellType: CaseIterable, CustomStringConvertible {
    case battle
    case market
    case boss
    case camp
    case empty
    case other
    case depart
    case path // this is the path from start to finish

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


class Player: ObservableObject {
    @Published var coordinate: Coordinate

    init(coordinate: Coordinate) {
        self.coordinate = coordinate
    }
}

class DonjonMap: ObservableObject {
    @Published var map: [[Cell?]] = []
    @Published var path: [Cell] = [] // this will hold the path cells
    @Published var player: Player // This will hold the player

    init() {
        // Place the player at the start by default
        player = Player(coordinate: Coordinate(x: 0, y: 0))
        
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
        player.coordinate = Coordinate(x: 0, y: 0)
    }
    
    func movePlayerUp() {
        let oldCoordinate = player.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: player.coordinate.x, y: player.coordinate.y - 1)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            player.coordinate = newCoordinate
            print("New position: (\(newCoordinate.x), \(newCoordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
        
    }
    
    func movePlayerDown() {
        let oldCoordinate = player.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: player.coordinate.x, y: player.coordinate.y + 1)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            player.coordinate = newCoordinate
            print("New position: (\(newCoordinate.x), \(newCoordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
    }
    
    func movePlayerLeft() {
        let oldCoordinate = player.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: player.coordinate.x - 1, y: player.coordinate.y)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            player.coordinate = newCoordinate
            print("New position: (\(newCoordinate.x), \(newCoordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
    }
    
    func movePlayerRight() {
        let oldCoordinate = player.coordinate
        print("Old position: (\(oldCoordinate.x), \(oldCoordinate.y))")
        let newCoordinate = Coordinate(x: player.coordinate.x + 1, y: player.coordinate.y)
        if let newCell = getCell(at: newCoordinate), newCell.clear {
            player.coordinate = newCoordinate
            print("New position: (\(player.coordinate.x), \(player.coordinate.y))")
        }
        self.objectWillChange.send() // Ajouter cet appel pour signaler le changement
    }
}
