//
//  ProgressBar.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 19/06/2023.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                

                Rectangle()
                    .frame(width: min(CGFloat(self.progress)*geometry.size.width, geometry.size.width), height: 20)
                    .foregroundColor(.green)
                    .cornerRadius(10)
                    
                    .animation(.linear(duration: 4.0))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: geometry.size.width , height: 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 7)
                    )
    
            }.cornerRadius(45.0)
        }
    }
}
