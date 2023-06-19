//
//  ContentView2.swift
//  Swipe Time
//
//  Created by Gab Richard on 19/06/2023.
//

import Foundation

import SwiftUI


struct ContentView2: View {
    @State var progressValue: Float = 0.0
    var body: some View {
        ZStack{
            SplashScreen2()
            
            VStack {
                ProgressBar(progress: self.$progressValue)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 20)
                    .offset(y: 350)
                    .padding(20.0).onAppear(){
                        self.progressValue = 0.30
                    }
                Button("Touch"){
                    if progressValue<0.90{
                        self.progressValue+=0.15
                    }else{
                        progressValue-=0.95
                    }
                }
            }
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
