//
//  SwipeAction.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import Foundation

enum ActionType: String {
    case attack
    case defense
    case special
    case other
}

class SwipeAction :Hashable {
    let type: ActionType
    let image: String
    let text: String
    let action: (Int) -> Void
    var direction: SwipeDirection?
    
    init(type: ActionType, image: String, text: String, action: @escaping (Int) -> Void) {
        self.type = type
        self.image = image
        self.text = text
        self.action = action
    }
    
    func setDirection(_ direction: SwipeDirection) {
        self.direction = direction
    }
    
    func performAction(param: Int) {
        action(param)
    }
    
    func isHorizontal()-> Bool{
        return self.direction==SwipeDirection.right || self.direction == SwipeDirection.left
    }
    
    static func == (lhs: SwipeAction, rhs: SwipeAction) -> Bool {
            // Implement the equality check for SwipeAction
            // Return true if the SwipeActions are considered equal, false otherwise
            // You can compare properties of the SwipeActions to determine equality
            return lhs.type == rhs.type && lhs.image == rhs.image && lhs.text == rhs.text
        }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(type)
            hasher.combine(image)
            hasher.combine(text)
        }
}
