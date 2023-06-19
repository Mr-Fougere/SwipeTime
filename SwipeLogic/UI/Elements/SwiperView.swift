//
//  SwiperView.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import SwiftUI

struct SwiperView: View {
    let swipePad: SwipePad
    
    init(swipePad: SwipePad) {
        self.swipePad = swipePad;
    }
    
    var body: some View {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    HStack(spacing:0){
                        SwipeActionView(swipeAction: swipePad.getAction(for: .left), geometryWidth: geometry.size.width, geometryHeight: geometry.size.width).frame(width: geometry.size.height * 0.2, height: geometry.size.height * 0.6)
                    }.frame(maxWidth: .infinity,alignment: .trailing)
                    
                    VStack(spacing: 0){
                        SwipeActionView(swipeAction: swipePad.getAction(for: .up), geometryWidth: geometry.size.width, geometryHeight: geometry.size.width).frame(width: geometry.size.height * 0.6, height: geometry.size.height * 0.2)

                        SwipePadContainerView(swipePad: swipePad)
                            .frame(width: geometry.size.height * 0.6, height: geometry.size.height * 0.6)
                        
                        SwipeActionView(swipeAction: swipePad.getAction(for: .down), geometryWidth: geometry.size.width, geometryHeight: geometry.size.width).frame(width: geometry.size.height * 0.6, height: geometry.size.height * 0.2)
                    }
                    
                    HStack(spacing:0){
                        SwipeActionView(swipeAction: swipePad.getAction(for: .right), geometryWidth: geometry.size.width, geometryHeight: geometry.size.width).frame(width: geometry.size.height * 0.2, height: geometry.size.height * 0.6)
                    }.frame(maxWidth: .infinity,alignment: .leading)
                }
            }
        }
}

struct SwiperView_Preview: PreviewProvider {
    static var previews: some View {
        let sampleSwipeAction1 = SwipeAction(type: .other, image: "none", text: "missing"){ _ in  print("missing")}
        let sampleSwipePad = SwipePad(rightAction: sampleSwipeAction1, leftAction: sampleSwipeAction1, upAction: sampleSwipeAction1, downAction: sampleSwipeAction1)
        SwiperView(swipePad: sampleSwipePad)
    }
}

