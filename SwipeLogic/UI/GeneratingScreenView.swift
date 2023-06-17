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
            Color(.green)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                AppState.shared.userState = .onDungeonMap
            }
        }
    }
}

struct GeneratinScreenView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratinScreenView()
    }
}
