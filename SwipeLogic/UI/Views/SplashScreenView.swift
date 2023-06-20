//
//  SplashScreen.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 17/06/2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State var progressValue: Float = 0.0
    
    
    var body: some View {
        ZStack{
            
            Image("SplashScreen")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
            VStack{
                Spacer()
                ProgressBar(progress: self.$progressValue)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 20)
                    .padding(20.0)
                    .onAppear {
                        self.progressValue = 1.0
                        AppState.shared.adventure = AdventureGenerator().perform()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                            AppState.shared.userState = .inMenu
                        }
                    }
            }
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
