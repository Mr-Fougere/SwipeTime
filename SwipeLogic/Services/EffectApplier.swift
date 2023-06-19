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
        print(heroAction.bindingKey)

        print(monsterAction.bindingKey)

        if self.monsterAction != self.heroAction {
            self.verdict = true
        }
    }
    
    func perform(){
        if !verdict {
            return
        }
        //monsterAction.result = randomTimingResult()
        //decryptAction(action: monsterAction)
        print(heroAction.bindingKey)
        print(monsterAction.bindingKey)

        decryptAction(action: heroAction)
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
    
    private func decryptAction(action: Action){
        let action = action
        if action.swipeEffect == nil {
            return
        }
        decryptEffect(effect: action.swipeEffect, isUser: action.isUser)
    }
    
    private func decryptEffect(effect: SwipeEffect?,isUser: Bool ){
        let effect: SwipeEffect = effect!
        let targetCharacter: Character = getCharacter(target: effect.target)
        let triggerCharacter: Character = getCharacter(target: isUser ? .you : .opponent)
        let refStat:Int = getStat(stat: effect.referenceStat, character: triggerCharacter)
        updateStat(stat: effect.affectedStat, character: targetCharacter, value: effect.value * refStat)
    }
    
    private func getCharacter(target: Target)-> Character{
        switch target {
        case .opponent:
            return battle.monsters[0]
        default:
            return battle.hero
        }
    }
    
    private func getStat(stat: CharacterStat,character: Character)->Int{
        switch stat {
        case .attack:
            return character.attack
        case .defense:
            return character.defense
        case .protection:
            return character.protection
        case .combo:
            return character.timingBar!.combo
        case .one:
            return 1
        default:
            return character.healthPoints
        }
    }
    
    private func updateStat(stat: CharacterStat,character: Character,value: Int){
        switch stat {
        case .attack:
             character.attack += value
        case .defense:
            character.defense += value
        case .protection:
            character.protection += value
        case .combo:
            character.timingBar?.combo += value
        default:
            character.currentHealthPoints += value
        }
    }
}


