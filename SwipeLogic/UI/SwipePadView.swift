//
//  SwipePadView.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import UIKit

class SwipePadView: UIView {
    private var swipePad: SwipePad!
   
    
    convenience init(frame: CGRect, swipePad: SwipePad) {
            let height = frame.height * 0.6
            let width = height
            let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: height)
            self.init(frame: newFrame)
            self.swipePad = swipePad
            addSwipeGestureRecognizers()
            backgroundColor = .lightGray// Ajout de la couleur de fond grise
        }
    
    private func addSwipeGestureRecognizers() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        
        for direction in directions {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeGestureRecognizer.direction = direction
            self.addGestureRecognizer(swipeGestureRecognizer)
        }
    }
    
    @objc private func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
        guard let direction = getDirection(from: gestureRecognizer.direction) else {
            return
        }
        
        swipePad.callAction(for: direction)
    }
    
    func updateSwipeActions(swipePad: SwipePad) {
            self.swipePad = swipePad
    }
    
    private func getDirection(from gestureDirection: UISwipeGestureRecognizer.Direction) -> SwipeDirection? {
        switch gestureDirection {
        case .right:
            return .right
        case .left:
            return .left
        case .up:
            return .up
        case .down:
            return .down
        default:
            return nil
        }
    }
}

