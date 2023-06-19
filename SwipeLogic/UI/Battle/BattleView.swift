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
        @StateObject var hero: Hero
        @StateObject var monster: Monster
        
        init() {
            if let existingBattle = AppState.shared.battle {
                _battle = StateObject(wrappedValue: existingBattle)
                let hero = existingBattle.hero
                let monster = existingBattle.monsters[0]
                _hero = StateObject(wrappedValue: hero)
                _monster = StateObject(wrappedValue: monster)
            } else {
                let newBattle: Battle = BattleGenerator().perform()
                _battle = StateObject(wrappedValue: newBattle)
                AppState.shared.battle = newBattle
                let hero = newBattle.hero
                let monster = newBattle.monsters[0]
                _hero = StateObject(wrappedValue: hero)
                _monster = StateObject(wrappedValue: monster)
            }
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
                            TitleView(text: "Battle", type: 3).frame(height: geometry.size.height * 0.15)
                            HStack() {
                                CharacterView(character: hero)
                                CharacterView(character: monster)
                            }.frame(height: geometry.size.height * 0.6)
                            TimingBarView(battle: battle).frame(height: geometry.size.height * 0.2)
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
