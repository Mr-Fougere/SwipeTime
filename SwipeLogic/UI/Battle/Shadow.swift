//
//  Shadow.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import SwiftUI

struct ShadowView: View {
    
    let height: CGFloat
    let width: CGFloat
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Ellipse()
            .fill(Color.black)
            .frame(width: width, height: height)
            .opacity(0.3)
    }
}

struct ShadowView_Previews: PreviewProvider {
    static var previews: some View {
        ShadowView(width: 100 , height: 10)
    }
}
