    //
    //  SwipeActionView.swift
    //  SwipeLogic
    //
    //  Created by Alexandre Gaubert on 14/06/2023.
    //
    
    import SwiftUI
    
    struct SwipeActionView: View {
        let swipeAction: SwipeAction
        let width: CGFloat
        let height: CGFloat
        
        init(swipeAction: SwipeAction, geometryWidth: CGFloat,geometryHeight: CGFloat) {
            self.swipeAction = swipeAction
            self.width = swipeAction.isHorizontal() ? geometryHeight * 0.2 : geometryHeight * 0.6
            self.height = swipeAction.isHorizontal() ? geometryHeight * 0.6 : geometryHeight * 0.2
        }
        
        var body: some View {
            ZStack {
                Color(.green)
                /*
                Image(swipeAction.image)
                    .resizable()
                    .frame(width: width, height: height)
                    .scaledToFit()
                    .opacity(0.7)
                    .clipped()
                 */
     Text(swipeAction.text)
            }
            
        }
    }
    
    
    struct SwipeActionView_Previews: PreviewProvider {
        static var previews: some View {
            let sampleSwipeAction = SwipeAction(type: .other, image: "none", text: "missing"){ print("missing")}
            SwipeActionView(swipeAction: sampleSwipeAction, geometryWidth: 10.0,geometryHeight: 10.0)
        }
    }
    
