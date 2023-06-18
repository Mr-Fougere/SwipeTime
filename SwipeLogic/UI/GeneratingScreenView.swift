//
//  SplashScreen.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 17/06/2023.
//

import SwiftUI

struct GeneratinScreenView: View {
    var body: some View {
        VStack{
            Color(.systemIndigo)
        }.onAppear {
            AppState.shared.adventure = AdventureGenerator().perform()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                AppState.shared.userState = .inBattle
            }
        }
    }
}

struct GeneratinScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratinScreenView()
    }
}
