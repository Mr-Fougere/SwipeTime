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
        heroAction.inProcess = true
        monsterAction.inProcess = true
        if self.monsterAction != self.heroAction {
            self.verdict = true
        }
    }
    
    func perform(){
        if !verdict {
            return
        }
        monsterAction.result = randomTimingResult()
        resetProtection()
        var sortedActions: [Action] = [monsterAction,heroAction]
            
        sortedActions.sort { (action1, action2) -> Bool in
            if action1.swipeEffect?.type == .attack && action2.swipeEffect?.type != .attack {
                return false
            } else if action1.swipeEffect?.type != .attack && action2.swipeEffect?.type == .attack {
                return true
            } else {
                return false
            }
        }
        
        for action in sortedActions {
            decryptAction(action: action)
        }
        removeActionApplied()
    }
    
    private func resetProtection(){
        battle.hero.protection = 0
        battle.monsters[0].protection = 0
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
        let multiplier :Float = getMultiplier(timingResult: action.result)
        decryptEffect(effect: action.swipeEffect, isUser: action.isUser, multiplier: multiplier)
    }
    
    private func decryptEffect(effect: SwipeEffect?,isUser: Bool, multiplier: Float ){
        let effect: SwipeEffect = effect!
        let targetCharacter: Character = getCharacter(target: isUser ? .opponent : .you)
        let triggerCharacter: Character = getCharacter(target: isUser ? .you : .opponent)
        let refStat:Int = getStat(stat: effect.referenceStat, character: triggerCharacter)
        let roundedValue: Int = Int(Float(effect.value * refStat) * multiplier)
        updateStat(stat: effect.affectedStat, character: targetCharacter, value: roundedValue)
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
            print("protection : \(value)")
            character.protection += value
        case .combo:
            character.timingBar?.combo += value
        default:
            print("atk : \(value)")
            print("protection : \(character.protection)")
            let remainingDamage = character.protection + value
            print("remaining : \(remainingDamage)")

            character.currentHealthPoints += remainingDamage
        }
    }
    
    private func getMultiplier(timingResult: TimingResult)-> Float{
        switch timingResult {
        case .perfect:
            return 2.0
        case .great:
            return 1
        case .good:
            return 0.5
        default:
            return 0
        }
        
    }
}


