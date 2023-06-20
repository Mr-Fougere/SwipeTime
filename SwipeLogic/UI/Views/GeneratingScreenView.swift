//
//  SplashScreen.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 17/06/2023.
//

import SwiftUI

struct GeneratinScreenView: View {
    
    @State var progressValue: Float = 0.0

    var body: some View {
        ZStack{
            Image("Generation")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            VStack{
                TitleView(text: "New adventure", type: 3)
                Spacer()
                ProgressBar(progress: self.$progressValue)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 20)
                    .padding(20.0)
                    }.onAppear {
                        self.progressValue = 1.0
                        AppState.shared.adventure = AdventureGenerator().perform()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            AppState.shared.userState = .inBattle
                        }
                    }
            }
            
    }
}

struct GeneratinScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratinScreenView()
    }
}
