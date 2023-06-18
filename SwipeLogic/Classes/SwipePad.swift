//
//  File.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import Foundation

enum SwipeDirection {
    case right, left, up, down
}

class SwipePad {
    private var rightAction: SwipeAction
    private var leftAction: SwipeAction
    private var upAction: SwipeAction
    private var downAction: SwipeAction
    
    init(rightAction: SwipeAction, leftAction: SwipeAction, upAction: SwipeAction, downAction: SwipeAction) {
        self.rightAction = rightAction
        self.leftAction = leftAction
        self.upAction = upAction
        self.downAction = downAction
        initDirection()
    }
    
    func callAction(for direction: SwipeDirection) {
            let swipeAction = getAction(for: direction)
            if AppState.shared.userState == .inBattle {
                swipeAction.performAction(param: 1)
            }else{
                swipeAction.performAction(param: 1)
            }
       }
    
    func initDirection(){
        self.rightAction.setDirection(.right)
        self.downAction.setDirection(.down)
        self.leftAction.setDirection(.left)
        self.upAction.setDirection(.up)
    }

    func changeAction(direction: SwipeDirection,newAction: SwipeAction) {
            switch direction {
            case .right:
                newAction.setDirection(.right)
                rightAction = newAction
            case .left:
                newAction.setDirection(.left)
                leftAction = newAction
            case .up:
                newAction.setDirection(.up)
                upAction = newAction
            case .down:
                newAction.setDirection(.down)
                downAction = newAction
            }
        }
    
    func getAllActions()->[SwipeAction]{
        return [leftAction,upAction,rightAction,downAction]
    }
    
    func getAction(for direction: SwipeDirection) -> (SwipeAction) {
          switch direction {
          case .right:
              return rightAction
          case .left:
              return leftAction
          case .up:
              return upAction
          case .down:
              return downAction
          }
      }
}

