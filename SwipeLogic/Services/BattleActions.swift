    //
    //  MenuActions.swift
    //  SwipeLogic
    //
    //  Created by Alexandre Gaubert on 14/06/2023.
    //

    import Foundation


    import Foundation

    class BattleActions {
        var actions: [SwipeAction]
        
        init(actions: [SwipeAction]) {
            self.actions = actions
        }
        
        func create() -> SwipePad {
            var swipeActions: [String: SwipeAction] = [:]
            
            for action in actions {
                switch action.type {
                case .attack:
                    swipeActions["leftAction"] = action
                case .defense:
                    swipeActions["rightAction"] = action
                case .other:
                    swipeActions["downAction"] = action
                case .special:
                    swipeActions["upAction"] = action
                }
            }
            
            return SwipePad(
                rightAction: swipeActions["rightAction"] ?? Basics().emptySwipeAction(),
                leftAction: swipeActions["leftAction"] ?? Basics().emptySwipeAction(),
                upAction: swipeActions["upAction"] ?? Basics().emptySpecial(),
                downAction: swipeActions["downAction"] ?? Basics().emptyOther()
            )
        }
    }

