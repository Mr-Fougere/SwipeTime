//
//  SplashScreen.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 17/06/2023.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack{
            Color(.blue)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                AppState.shared.userState = .inMenu
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
