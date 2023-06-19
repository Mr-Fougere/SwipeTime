//
//  CharacterView.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import SwiftUI



struct CharacterView: View {
    
    @StateObject private var character: Character

    
    init(character: Character) {
        _character = StateObject(wrappedValue: character);
    }
    
    
    var body: some View {
        GeometryReader { geometry in
                    VStack {
                        HealthBar(maxHP: character.healthPoints, currentHP: character.currentHealthPoints, isUser: type(of: character) == type(of: Basics().basicHero()))
                            .frame(height: geometry.size.height * 0.1)
                            .padding(.horizontal, geometry.size.width * 0.20)
                        ZStack(alignment: .bottom){
                            ShadowView(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6 * 0.1)
                            Image(character.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, geometry.size.width * 0.20)
                                .frame(height: geometry.size.height * 0.7)
                        }
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom) 
                }
    }
}

struct CharacterView_Preview: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Basics().basicHero())
    }
}


