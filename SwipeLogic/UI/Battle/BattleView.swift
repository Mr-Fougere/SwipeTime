//
//  SplashScreen.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 17/06/2023.
//

import SwiftUI
struct BattleView: View {
    var adventure: Adventure = AppState.shared.adventure!
    
    var swipePad: SwipePad {
        return BattleActions(actions: adventure.hero.swipeActions).create()
    }

    @StateObject var battle: Battle

    init() {
            if let existingBattle = AppState.shared.battle {
                _battle = StateObject(wrappedValue: existingBattle)
            } else {
                let newBattle: Battle = BattleGenerator().perform()
                _battle = StateObject(wrappedValue: newBattle)
                AppState.shared.battle = newBattle
            }
        }
    
    var hero: Character {
           return battle.hero
       }
       
   var monster: Character {
       return battle.monsters[0]
   }

    var body: some View {
        ZStack {
            Color(adventure.currentDungeon.color)
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    ZStack {
                        Image(adventure.currentDungeon.name.rawValue)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        VStack{
                            HStack() {
                                CharacterView(character: self.hero)
                                CharacterView(character: self.monster)
                            }.frame(height: geometry.size.height * 0.8)
                            TimingBarView(battle: self.battle).frame(height: geometry.size.height * 0.1)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
                
                Spacer()
                
                SwiperView(swipePad: swipePad)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
            }
        }
    }
}

struct BattleView_Previews: PreviewProvider {
    static var previews: some View {
        BattleView()
    }
}
