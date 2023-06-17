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
            let swipeActionRight = SwipeAction(type: .other, image: "soon", text: "soon") {
                print("Right action performed!")
            }
            
            let swipeActionLeft = SwipeAction(type: .other, image: "soon_2", text: "soon") {
                print("Left action performed!")
            }
                
            let swipeActionUp = SwipeAction(type: .other, image: "new_adventure", text: "new adventure") {
                AppState.shared.userState = .selectDifficulty
            }
            
            let swipeActionDown = SwipeAction(type: .other, image: "options", text: "options") {
                AppState.shared.userState = .selectOption
            }
            return [swipeActionRight,swipeActionLeft,swipeActionUp,swipeActionDown]
        }
        
        func selectDifficultyActions()->[SwipeAction]{
            let swipeActionRight = SwipeAction(type: .other, image: "easy", text: "easy") {
                AppState.shared.difficulty = .easy
            }
            
            let swipeActionLeft = SwipeAction(type: .other, image: "hard", text: "hard") {
                AppState.shared.difficulty = .hard
            }
                
            let swipeActionUp = SwipeAction(type: .other, image: "medium", text: "medium") {
                AppState.shared.difficulty = .medium
            }
            
            let swipeActionDown = SwipeAction(type: .other, image: "back", text: "back") {
                AppState.shared.userState = .inMenu
            }
            return [swipeActionRight,swipeActionLeft,swipeActionUp,swipeActionDown]
        }
        
        func selectOptionsAction()->[SwipeAction]{
            let swipeActionRight = SwipeAction(type: .other, image: "flag_fr", text: "french") {
                AppState.shared.language = .french
                AppState.shared.userState = .inMenu
            }
            
            let swipeActionLeft = SwipeAction(type: .other, image: "flag_jp", text: "japanese") {
                AppState.shared.language = .japanese
                AppState.shared.userState = .inMenu
            }
                
            let swipeActionUp = SwipeAction(type: .other, image: "back", text: "back") {
                AppState.shared.userState = .inMenu
            }
            
            let swipeActionDown = SwipeAction(type: .other, image: "flag_uk", text: "english") {
                AppState.shared.language = .english
                AppState.shared.userState = .inMenu
            }
            return [swipeActionRight,swipeActionLeft,swipeActionUp,swipeActionDown]
        }
        
    }
