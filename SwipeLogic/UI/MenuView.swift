//
//  ContentView.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 14/06/2023.
//

import SwiftUI

struct SwipePadContainerView: UIViewRepresentable {
    let swipePad: SwipePad
    
    func makeUIView(context: Context) -> UIView {
        let swipePadView = SwipePadView(frame: .zero, swipePad: swipePad)
        return swipePadView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let swipePadView = uiView as? SwipePadView {
                    swipePadView.updateSwipeActions(swipePad: swipePad)
                }
    }
}


struct MenuView: View {

    @ObservedObject var appState = AppState.shared
        
    var swipePad: SwipePad {
        return MenuActions(currentState: appState.userState).update()
    }

    var body: some View {
            ZStack{
                Image("bg_menu")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.7)
                    .clipped()
                
                VStack(spacing: 0) {
                    Image("swipe_time_logo")
                        .resizable()
                        .scaledToFit()
                        .clipped().frame(width: UIScreen.main.bounds.width)
                    Spacer()
                    SwiperView(swipePad: swipePad).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                }
                .background(Color.clear)
                .edgesIgnoringSafeArea(.top)
            }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
