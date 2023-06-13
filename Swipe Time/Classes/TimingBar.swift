enum TimingResult {
    case perfect
    case great
    case good
    case miss
}


class TimingBar {
    let perfectTiming: Int
    let greatTiming: Int
    let goodTiming: Int
    let combo: Int
    
    init(perfectTiming: Int, greatTiming: Int, goodTiming: Int, combo: Int) {
        self.perfectTiming = perfectTiming
        self.greatTiming = greatTiming
        self.goodTiming = goodTiming
        self.combo = combo
    }

    func getTimingResult(time: Int) -> TimingResult {
    if time <= self.perfectTiming {
        return .perfect
    } else if time <= self.greatTiming {
        return .great
    } else if time <= self.goodTiming {
        return .good
    } else {
        return .miss
    }
}
}

class Action {
    var timing: Int
    var swipeAction: SwipeAction?
    var owner: Character
    var result: TimingResult?
    var bindingKey: String
    
    init(timing: Int, swipeAction: SwipeAction?, owner: Character) {
        self.timing = timing
        self.swipeAction = swipeAction
        self.owner = owner
        self.bindingKey = generateBindingKey()
        
        startTimer()
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            self.timing -= 1
            
            if self.timing <= 0 {
                timer.invalidate()
                // Gérer la fin du timing, par exemple, déclencher une action ou mettre à jour le résultat.
            }
        }
    }
}
