//
//  Title.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 19/06/2023.
//

import SwiftUI

struct TitleView: View {
    
    let text :String
    let type: Int
    
    init(text: String,type: Int) {
        self.text = text
        self.type = type
        }
    
    var body: some View {
        ZStack(alignment: .center){
            Image("title_parch\(type)")
                .resizable()
                .scaledToFit()
            Text(text)
        }.padding(.top,20)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(text:"Missing",type:1)
    }
}
