//
//  EffectApplier.swift
//  SwipeLogic
//
//  Created by Alexandre Gaubert on 19/06/2023.
//

import Foundation

class EffectApplier{
    
    let timingResults: [TimingResult] = [.good, .great, .perfect, .miss]
    var heroAction: Action
    var monsterAction: Action
    let battle: Battle = AppState.shared.battle!
    var verdict: Bool = false
    
    init(action: Action) {
        if action.isUser {
            self.heroAction = action
            self.monsterAction = action
            self.monsterAction = retrieveMonsterAction()
        }else{
            self.monsterAction = action
            self.heroAction = action
            self.heroAction = retrieveHeroAction()
        }
        if self.monsterAction != self.heroAction {
            self.verdict = true
        }
    }
    
    func perform(){
        if !verdict {
            return
        }
        if heroAction.result == nil {
            heroAction.result = .miss
        }
        monsterAction.result = randomTimingResult()
        battle.hero.currentHealthPoints -= 10
        
        removeActionApplied()
    }
    
    private func retrieveHeroAction() -> Action{
        let doubleBindingKey: String = monsterAction.bindingKey
        let heroActions = battle.hero.timingBar?.actions.filter { $0.bindingKey == doubleBindingKey }
        if heroActions!.count > 0 {
            return heroActions![0]
        }
        return monsterAction
    }
    
    private func retrieveMonsterAction() -> Action{
        let doubleBindingKey: String = heroAction.bindingKey
        let monsterActions = battle.monsters[0].timingBar?.actions.filter { $0.bindingKey == doubleBindingKey }
        if monsterActions!.count > 0 {
            return monsterActions![0]
        }
        return heroAction
    }

    private func removeActionApplied(){
        battle.hero.timingBar?.removeResolvedActions()
        battle.monsters[0].timingBar?.removeResolvedActions()
    }
    private func randomTimingResult()-> TimingResult{
        return timingResults.randomElement()!
    }
}


