    //
    //  MenuActions.swift
    //  SwipeLogic
    //
    //  Created by Alexandre Gaubert on 14/06/2023.
    //

    import Foundation


    class MenuActions{
        
        var state: UserState = .inMenu
        
        init(currentState :UserState) {
            self.state = currentState
        }
        
        func update()->SwipePad{
            let swipeActions:[SwipeAction]
            switch state {
            case .selectOption:
                swipeActions = selectOptionsAction();
            case .selectDifficulty:
                swipeActions = selectDifficultyActions();
            default:
                swipeActions = inMenuAction();
            }
            
            return SwipePad(
                rightAction: swipeActions[0],
                leftAction: swipeActions[1],
                upAction: swipeActions[2],
                downAction: swipeActions[3]
            )
        }
        
        func inMenuAction()->[SwipeAction]{
            let swipeActionRight = SwipeAction(type: .other, image: "soon1", text: "soon") { param in
                print("Right action performed!")
            }
            
            let swipeActionLeft = SwipeAction(type: .other, image: "soon2", text: "soon") {param in
                print("Left action performed!")
            }
                
            let swipeActionUp = SwipeAction(type: .other, image: "newAdventure", text: "new adventure") {param in
                AppState.shared.userState = .selectDifficulty
            }
            
            let swipeActionDown = SwipeAction(type: .other, image: "options", text: "options") {param in
                AppState.shared.userState = .selectOption
            }
            return [swipeActionRight,swipeActionLeft,swipeActionUp,swipeActionDown]
        }
        
        func selectDifficultyActions()->[SwipeAction]{
            let swipeActionRight = SwipeAction(type: .other, image: "easy", text: "easy") {param in
                AppState.shared.difficulty = .easy
                AppState.shared.userState = .generatingDungeon
            }
            
            let swipeActionLeft = SwipeAction(type: .other, image: "hard", text: "hard") {param in
                AppState.shared.difficulty = .hard
                AppState.shared.userState = .generatingDungeon
            }
                
            let swipeActionUp = SwipeAction(type: .other, image: "medium", text: "medium") {param in
                AppState.shared.difficulty = .medium
                AppState.shared.userState = .generatingDungeon
            }
            
            let swipeActionDown = SwipeAction(type: .other, image: "back", text: "back") {param in
                AppState.shared.userState = .inMenu
            }
            return [swipeActionRight,swipeActionLeft,swipeActionUp,swipeActionDown]
        }
        
        func selectOptionsAction()->[SwipeAction]{
            let swipeActionRight = SwipeAction(type: .other, image: "flagFR", text: "FR") {param in
                AppState.shared.language = .french
                AppState.shared.userState = .inMenu
            }
            
            let swipeActionLeft = SwipeAction(type: .other, image: "flagJP", text: "JP") {param in
                AppState.shared.language = .japanese
                AppState.shared.userState = .inMenu
            }
                
            let swipeActionUp = SwipeAction(type: .other, image: "back", text: "back") {param in
                AppState.shared.userState = .inMenu
            }
            
            let swipeActionDown = SwipeAction(type: .other, image: "flagEN", text: "EN") {param in
                AppState.shared.language = .english
                AppState.shared.userState = .inMenu
            }
            return [swipeActionRight,swipeActionLeft,swipeActionUp,swipeActionDown]
        }
        
    }
