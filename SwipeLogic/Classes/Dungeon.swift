import SwiftUI

enum EventType :String{
    case battle
    case boss
    case camp
    case unknown
    case market
    case empty
}

enum MapName :String {
    case forest
    case fireKingdom
    case iceKingdom
    case lumpySpace
    case nightosphere
    case candyKingdom
}

class DungeonCase {
    let positionX: Int
    let positionY: Int
    let event: EventType
    let hideEvent: Bool
    let clear: Bool
    
    init(positionX: Int, positionY: Int, event: EventType, hideEvent: Bool, clear: Bool) {
        self.positionX = positionX
        self.positionY = positionY
        self.event = event
        self.clear = clear
        self.hideEvent = hideEvent
    }
}
