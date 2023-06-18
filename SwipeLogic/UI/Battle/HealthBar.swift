//
//  HealthBar.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import SwiftUI

struct HealthBar: View {
    
    let percentage: Float
    let isUser: Bool
    
    
    init(maxHP: Int,currentHP: Int,isUser : Bool) {
        self.percentage = Float(currentHP / maxHP);
        self.isUser = isUser
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                           Rectangle()
                            .foregroundColor(.clear)
                               .opacity(0.3)
                               .frame(width: geometry.size.width, height: 10)
                               .cornerRadius(5)
                               .overlay(
                                   RoundedRectangle(cornerRadius: 5)
                                       .stroke(Color.white, lineWidth: 1)
                               )
                           
                           Rectangle()
                            .foregroundColor(isUser ? .green : .red)
                            .frame(width: geometry.size.width * CGFloat(percentage), height: 10)
                               .cornerRadius(5)
        }
    }
    }
    
}


struct HealthBar_Previews: PreviewProvider {
    static var previews: some View {
        HealthBar(maxHP: 100, currentHP: 100, isUser: true)
    }
}
