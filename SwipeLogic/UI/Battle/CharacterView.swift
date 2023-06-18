//
//  CharacterView.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterView: View {
    let character: Character
    
    init(character: Character) {
        self.character = character;
    }
    
    var body: some View {
        VStack{
            ZStack{
                HealthBar(maxHP: character.healthPoints, currentHP: character.currentHealthPoints, isUser: type(of: character) == Hero.Type.self)
            }
            AnimatedImage(name: character.name)
        }.frame(width: UIScreen.main.bounds.width * 0.5,alignment: .center)
    }
}

struct CharacterView_Preview: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Basics().basicHero())
    }
}


