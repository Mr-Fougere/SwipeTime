//
//  HealthBar.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import SwiftUI

struct HealthBar: View {
    
    var maxHP: Int
    var currentHP: Int
    let isUser: Bool
    
    var percentage: Float {
        return Float(currentHP) / Float(maxHP)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(isUser ? .green : .red)
                    .frame(width: geometry.size.width * CGFloat(percentage), height: 15)
                    .cornerRadius(10)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .opacity(0.3)
                    .frame(width: geometry.size.width, height: 15)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 3)
                    )
            }
        }
    }
    
}


struct HealthBar_Previews: PreviewProvider {
    static var previews: some View {
        HealthBar(maxHP: 100, currentHP: 100, isUser: true)
    }
}
