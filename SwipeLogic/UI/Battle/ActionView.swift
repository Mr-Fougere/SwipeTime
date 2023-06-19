//
//  ActionView.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 19/06/2023.
//

import SwiftUI

struct ActionView: View {
    @ObservedObject private var currentAction: Action

    init(action: Action) {
        self.currentAction = action
    }
    
    var body: some View {
        GeometryReader { geometry in
                if currentAction.isUser {
                    ZStack {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)

                        Circle()
                            .stroke(Color.green, lineWidth: 2)
                            .frame(width: 45, height: 45)
                    }
                    .position(x: calculatePositionX(user: true), y: geometry.size.height * 0.5)
                    .onChange(of: currentAction.timing) { newValue in
                       
                    }
                } else {
                    ZStack {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                        
                        Image(currentAction.swipeAction!.type.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        Circle()
                            .stroke(Color.red, lineWidth: 2)
                            .frame(width: 45, height: 45)

                    }
                    .position(x: calculatePositionX(user: false), y: geometry.size.height * 0.5)
                    .onChange(of: currentAction.timing) { newValue in
                        
                    }
                }
        }
        
    }
        
    private func calculatePositionX(user: Bool) -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            var positionX: CGFloat = 0
               
               if user {
                   positionX = screenWidth / 2 - screenWidth / 2 * CGFloat(currentAction.timing) / 100
               } else {
                   positionX = screenWidth / 2 + screenWidth / 2 * CGFloat(currentAction.timing) / 100
               }
            return positionX
        
    }
    }
