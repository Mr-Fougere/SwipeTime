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
                Image(swipeAction.image)
                    .resizable()
                VStack{
                    Spacer()
                    Text(swipeAction.text)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .kerning(1)
                            .shadow(radius: 10)
                    swipeAction.type == .attack || swipeAction.type  == .defense ? nil : Spacer()
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: swipeAction.text != "" ?  5 : 0)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 0)
            }
        }
    }
    
    
    struct SwipeActionView_Previews: PreviewProvider {
        static var previews: some View {
            let sampleSwipeAction = SwipeAction(type: .other, image: "none", text: "missing"){param in  print("missing")}
            SwipeActionView(swipeAction: sampleSwipeAction, geometryWidth: 10.0,geometryHeight: 10.0)
        }
    }
    
