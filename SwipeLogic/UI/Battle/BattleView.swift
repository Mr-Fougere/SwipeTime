//
//  SplashScreen.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 17/06/2023.
//

import SwiftUI

struct BattleView: View {
    
    var adventure = AppState.shared.adventure

    var swipePad: SwipePad {
        return BattleActions(actions: (adventure?.hero.swipeActions)!).create()
    }
    
    var battle: Battle{
        return BattleGenerator().perform()
    }
    
    var body: some View {
        ZStack{
            Color(adventure?.currentDungeon.color ?? .black)
            VStack(spacing: 0) {
                HStack{
                    CharacterView(character: battle.hero)
                }
                Spacer()
                SwiperView(swipePad: swipePad).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
            }
        }
    }
}

struct BattleView_Previews: PreviewProvider {
    static var previews: some View {
        BattleView()
    }
}
