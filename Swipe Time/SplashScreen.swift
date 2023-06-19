//
//  SplashScreen.swift
//  Swipe Time
//
//  Created by Gab Richard on 19/06/2023.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Image("SplashScreen")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea(.all)

        VStack {
            Image("SwipeTimeLogo")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
                .offset(x:-12, y: -35)

            Spacer()
        }.ignoresSafeArea(.all)
    }
}
