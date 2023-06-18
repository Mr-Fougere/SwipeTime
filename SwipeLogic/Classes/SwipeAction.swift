//
//  SwipeAction.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import Foundation

enum ActionType {
    case attack
    case defense
    case special
    case other
}

class SwipeAction {
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
}

