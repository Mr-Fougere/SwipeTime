//
//  ProgressBar.swift
//  Swipe Time
//
//  Created by Gab Richard on 19/06/2023.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: 20)
                    .opacity(0.3)
                    .foregroundColor(Color.pink)

                Rectangle().frame(width: min(CGFloat(self.progress)*geometry.size.width, geometry.size.width), height: 20)
                    .foregroundColor(Color.pink)
                    .animation(.linear(duration: 2.0))
            }.cornerRadius(45.0)
        }
    }
}
