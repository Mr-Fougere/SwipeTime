//
//  TimingBar.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 18/06/2023.
//

import SwiftUI

struct TimingBarView: View {
    
    
    let colorUI :UIColor = (AppState.shared.adventure?.currentDungeon.color)!
    let heroTimingBar :TimingBar
    let monsterTimingbar: TimingBar
    @StateObject private var battle: Battle

    init(battle: Battle) {
        self._battle = StateObject(wrappedValue: battle)
        self.heroTimingBar = battle.hero.timingBar!
        self.monsterTimingbar = battle.monsters[0].timingBar!
    }
    
    var body: some View {
        GeometryReader { geometry in
                    ZStack(alignment: Alignment.center) { // Utiliser une VStack pour centrer l'interface utilisateur verticalement
                        HStack(spacing: 0) {
                            Color(colorUI)
                                .frame(height: geometry.size.height * 0.5)
                                .opacity(0.5)
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(colorUI), lineWidth: 5)
                                .frame(width: geometry.size.height, height: geometry.size.height)
                            
                            Color(colorUI)
                                .frame(height: geometry.size.height * 0.5)
                                .opacity(0.5)
                        }
                        Text(heroTimingBar.lastTiming.rawValue)
                        Text(monsterTimingbar.lastTiming.rawValue)
                            ForEach(monsterTimingbar.actions, id: \.self) { action in
                                ActionView(action: action)
                            }
                            
                            ForEach(heroTimingBar.actions, id: \.self) { action in
                                ActionView(action: action)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .onAppear(perform: { battle.startBattle() })
        }
    }
    
}


struct TimingBarView_Previews: PreviewProvider {
    static var previews: some View {
        TimingBarView(battle: Battle(hero: Basics().basicHero(), monsters: [], reward:[]))
    }
}
